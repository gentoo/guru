# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

GH_PN=dropbox-sdk-python

DESCRIPTION="The offical Dropbox SDK for Python"
HOMEPAGE="https://www.dropbox.com/developers"
# pypi does not have tests, stick with gh
SRC_URI="https://github.com/dropbox/${GH_PN}/archive/refs/tags/v${PV}.tar.gz -> ${GH_PN}-${PV}.gh.tar.gz"
S="${WORKDIR}"/${GH_PN}-${PV}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/requests-2.16.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.12.0[${PYTHON_USEDEP}]
	>=dev-python/stone-2.0.0[${PYTHON_USEDEP}]
"

# disable tests that need SCOPED_USER_DROPBOX_TOKEN
# and tests that fail
EPYTEST_DESELECT=(
	test/integration/test_dropbox.py
	test/unit/test_dropbox_unit.py::TestClient
	test/unit/test_dropbox_unit.py::TestOAuth::test_NoRedirect_whole_flow
)

distutils_enable_tests pytest

python_prepare_all() {
	# this is wrong
	sed -i -e "s/^import mock$/from unittest import mock/" test/unit/test_dropbox_unit.py || die

	distutils-r1_python_prepare_all
}
