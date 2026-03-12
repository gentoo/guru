# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
# py3.14: https://github.com/aws/chalice/issues/2150
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 #pypi

DESCRIPTION="Python Serverless Microframework for AWS"
HOMEPAGE="
	https://github.com/aws/chalice/
	https://pypi.org/project/chalice/
"
# no tests in sdist
SRC_URI="
	https://github.com/aws/chalice/archive/refs/tags/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# <dev-python/pip-25.1[${PYTHON_USEDEP}]: patched out
RDEPEND="
	<dev-python/click-9.0[${PYTHON_USEDEP}]
	>=dev-python/click-7[${PYTHON_USEDEP}]
	<dev-python/botocore-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/botocore-1.14.0[${PYTHON_USEDEP}]
	<dev-python/six-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/pip-9[${PYTHON_USEDEP}]
	<dev-python/jmespath-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/jmespath-0.9.3[${PYTHON_USEDEP}]
	<dev-python/pyyaml-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.3.1[${PYTHON_USEDEP}]
	<dev-python/inquirer-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/inquirer-3.0.0[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		<dev-python/boto3-2[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		<dev-python/websocket-client-2.0.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	# FIXME
	"tests/functional/cli/test_factory.py::test_can_create_botocore_session_debug"
	# looks to to be tricky
	"tests/unit/deploy/test_packager.py::TestPipRunner::test_build_wheel"
	# network-sandbox
	"tests/functional/test_awsclient.py::TestUpdateDomainName::test_update_domain_name_failed"
	"tests/functional/test_deployer.py::test_no_error_message_printed_on_empty_reqs_file"
	# pinned deps checker
	"tests/integration/test_package.py::TestPackage::test_can_package_with_dashes_in_name"
	"tests/integration/test_package.py::TestPackage::test_can_package_simplejson"
	"tests/integration/test_package.py::TestPackage::test_can_package_sqlalchemy"
	"tests/integration/test_package.py::TestPackage::test_can_package_pandas"
	"tests/integration/test_package.py::TestPackage::test_packaging_requirements_keeps_same_hash"
)
EPYTEST_PLUGINS=()
EPYTEST_XDIST=1
distutils_enable_tests pytest

PATCHES=(
	"${FILESDIR}"/chalice-1.32.0-botocore-unvendor.patch
)

python_prepare_all() {
	sed -e '/install_requires/,/^\]$/ { /pip/ s/<25.1// }' -i setup.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	epytest tests/unit tests/functional tests/integration
}
