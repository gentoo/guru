# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EPYTEST_IGNORE=( tests/integration )
MYPN="${PN}-python"
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 optfeature

DESCRIPTION="Confluent's Kafka Python Client"
HOMEPAGE="
	https://pypi.org/project/confluent-kafka/
	https://github.com/confluentinc/confluent-kafka-python
"
SRC_URI="https://github.com/confluentinc/${MYPN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MYPN}-${PV}"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="~dev-libs/librdkafka-1.9.0"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/fastavro-1.0[${PYTHON_USEDEP}]
		>=dev-python/avro-1.10.0[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}]

		dev-python/protobuf-python[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/pyflakes[${PYTHON_USEDEP}]
		dev-python/pyrsistent[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	rm "${ED}/usr/LICENSE.txt" || die
}

pkg_postinst() {
	optfeature "avro support" dev-python/fastavro dev-python/avro dev-python/requests
	optfeature "json support" dev-python/jsonschema dev-python/pyrsistent dev-python/requests
	optfeature "protobuf support" dev-python/protobuf-python dev-python/requests
	optfeature "schema-registry support" dev-python/requests
}
