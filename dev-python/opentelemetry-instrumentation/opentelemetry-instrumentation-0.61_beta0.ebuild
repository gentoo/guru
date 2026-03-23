# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

MY_PV=${PV/_beta/b}
MY_P="opentelemetry-python-contrib-${MY_PV}"

OTLP_PV=1.40.0
OTLP_P="opentelemetry-python-${OTLP_PV}"

DESCRIPTION="Instrumentation Tools & Auto Instrumentation for OpenTelemetry Python"
HOMEPAGE="
	https://opentelemetry.io/
	https://pypi.org/project/opentelemetry-instrumentation/
	https://github.com/open-telemetry/opentelemetry-python-contrib/
"
SRC_URI="
	https://github.com/open-telemetry/opentelemetry-python-contrib/archive/refs/tags/v${MY_PV}.tar.gz
		-> ${MY_P}.gh.tar.gz
	test? (
		https://github.com/open-telemetry/opentelemetry-python/archive/refs/tags/v${OTLP_PV}.tar.gz
			-> ${OTLP_P}.gh.tar.gz
	)
"
S="${WORKDIR}/${MY_P}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="
	~dev-python/opentelemetry-api-1.40.0[${PYTHON_USEDEP}]
	~dev-python/opentelemetry-semantic-conventions-1.40.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-18.0[${PYTHON_USEDEP}]
	>=dev-python/wrapt-1.0.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# TODO Investigate test failures
	opentelemetry-instrumentation/tests/test_utils.py::UnwrapTestCase::test_can_unwrap_object_attribute
	opentelemetry-instrumentation/tests/test_utils.py::UnwrapTestCase::test_can_unwrap_object_attribute_as_string
	opentelemetry-instrumentation/tests/test_utils.py::UnwrapTestCase::test_raises_import_error_if_cannot_find_module
	opentelemetry-instrumentation/tests/test_utils.py::UnwrapTestCase::test_raises_import_error_if_cannot_find_object
	opentelemetry-instrumentation/tests/test_utils.py::UnwrapTestCase::test_raises_import_error_if_path_not_well_formed
)

python_test() {
	cp -a "${BUILD_DIR}"/{install,test} || die
	local -x PATH=${BUILD_DIR}/test/usr/bin:${PATH}

	for dep in tests/opentelemetry-test-utils; do
		pushd "${WORKDIR}/${OTLP_P}/${dep}" >/dev/null || die
		distutils_pep517_install "${BUILD_DIR}"/test
		popd >/dev/null || die
	done

	epytest
}
