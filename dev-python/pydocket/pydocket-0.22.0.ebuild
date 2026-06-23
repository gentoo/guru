# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="A distributed background task system for Python functions"
HOMEPAGE="
	https://docket.lol/
	https://github.com/chrisguidry/docket
	https://pypi.org/project/pydocket/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/burner-redis-0.1.7[${PYTHON_USEDEP}]
	>=dev-python/cloudpickle-3.1.1[${PYTHON_USEDEP}]
	>=dev-python/cronsim-2.6[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-api-1.33.0[${PYTHON_USEDEP}]
	>=dev-python/prometheus-client-0.21.1[${PYTHON_USEDEP}]
	>=dev-python/py-key-value-aio-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/python-json-logger-2.0.7[${PYTHON_USEDEP}]
	>=dev-python/redis-5[${PYTHON_USEDEP}]
	>=dev-python/rich-13.9.4[${PYTHON_USEDEP}]
	>=dev-python/typer-0.15.1[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.12.0[${PYTHON_USEDEP}]
	>=dev-python/uncalled-for-0.3.2[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest-{asyncio,timeout} )
EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# requires dev-python/opentelemetry-exporter-prometheus
	tests/instrumentation/test_export.py::test_exports_metrics_as_prometheus_metrics

	# fails with xdist
	tests/instrumentation/test_tracing.py::test_admission_blocked_span_has_ok_status
)

src_prepare() {
	distutils-r1_src_prepare

	# no coverage
	sed -i \
		-e '/--cov/d' \
		-e '/--numprocesses/d' \
		-e '/--maxprocesses/d' \
		pyproject.toml || die
	rm tests/sitecustomize.py || die

	# mock various Docker types to avoid dev-python/docker dependency
	cat - tests/_container.py <<- 'EOF' > tests/_container.py.tmp || die
	class _DockerErrors:
	    ImageNotFound = Exception
	class _Docker:
	    errors = _DockerErrors
	docker = _Docker()
	DockerClient = object
	Container = object
	EOF
	mv tests/_container.py{.tmp,} || die

	sed -i \
		-e '/import docker\.errors/d' \
		-e '/from docker/d' \
		tests/_container.py || die

	sed -i \
		-e '/from docker import DockerClient/d' \
		-e '/from docker\.models\.containers import Container/d' \
		-e '/from tests\._container import (/a \    Container, DockerClient,' \
		tests/conftest.py || die
}

python_test() {
	local -x REDIS_VERSION="memory"
	epytest
}

pkg_postinst() {
	optfeature "metrics" dev-python/opentelemetry-sdk
}
