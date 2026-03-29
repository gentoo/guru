# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature

DESCRIPTION="Async Key-Value Store - A pluggable interface for KV Stores"
HOMEPAGE="
	https://github.com/strawgate/py-key-value
	https://pypi.org/project/py-key-value-aio/
"
MY_PN="py-key-value"
SRC_URI="
	https://github.com/strawgate/${MY_PN}/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/beartype-0.20.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.15.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/aiofile-3.5.0[${PYTHON_USEDEP}]
		>=dev-python/anyio-4.4.0[${PYTHON_USEDEP}]
		>=dev-python/cachetools-5.0.0[${PYTHON_USEDEP}]
		>=dev-python/cryptography-45.0.0[${PYTHON_USEDEP}]
		>=dev-python/diskcache-5.0.0[${PYTHON_USEDEP}]
		>=dev-python/pathvalidate-3.3.1[${PYTHON_USEDEP}]
		>=dev-python/pydantic-2.11.9[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=(
	inline-snapshot
	pytest-{asyncio,mock,timeout}
)
EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# We can't test most stores due to missing dependencies and/or Docker use
	tests/stores/aerospike/
	tests/stores/duckdb/
	tests/stores/dynamodb/
	tests/stores/elasticsearch/
	tests/stores/firestore/
	tests/stores/keyring/
	tests/stores/memcached/
	tests/stores/mongodb/
	tests/stores/opensearch/
	tests/stores/postgresql
	tests/stores/redis/
	tests/stores/rocksdb/
	tests/stores/s3/
	tests/stores/valkey/
	tests/stores/vault/
)

src_prepare() {
	distutils-r1_src_prepare

	# Disable Docker-dependent tests
	sed -e '/def should_run_docker_tests() -> bool:/a \    return False' \
		-e '/def should_skip_docker_tests() -> bool:/a \    return True' \
		-i "tests/conftest.py" || die
}

python_test() {
	epytest -o asyncio_mode=auto --dist=loadfile
}

pkg_postinst() {
	optfeature "disk- and file-backed cache" "dev-python/diskcache >=dev-python/pathvalidate-3.3.1"
	optfeature "encryption wrappers" dev-python/cryptography

	optfeature_header "Install optional key-value store backends:"
	optfeature "Elasticsearch" "dev-python/elasticsearch dev-python/aiohttp"
	optfeature "File-tree" "dev-python/aiofile dev-python/anyio"
	optfeature "system keyring" "dev-python/keyring dev-python/dbus-python"
	optfeature "memory" dev-python/cachetools
	optfeature "MongoDB" dev-python/pymongo
	optfeature "OpenSearch" dev-python/opensearch-py
	optfeature "PostgreSQL" dev-python/asyncpg
	optfeature "Pydantic" ">=dev-python/pydantic-2.11.9"
	optfeature "Redis" dev-python/redis
	optfeature "HashiCorp Vault" dev-python/hvac
}
