# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

MY_PN=dropbox-sdk-python
MY_P=${MY_PN}-${PV}

DESCRIPTION="The offical Dropbox SDK for Python"
HOMEPAGE="https://www.dropbox.com/developers"
# pypi does not have tests, stick with gh
SRC_URI="https://github.com/dropbox/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/requests-2.16.2[${PYTHON_USEDEP}]
	>=dev-python/stone-3.5.3[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"

# disable tests that need SCOPED_USER_DROPBOX_TOKEN
# and tests that fail
EPYTEST_DESELECT=(
	test/integration/test_dropbox.py
	test/unit/test_dropbox_unit.py::TestClient
	test/unit/test_dropbox_unit.py::TestOAuth::test_NoRedirect_whole_flow
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_prepare() {
	if [[ ${PV} == *_p* ]] ; then
		local MY_PV=$(ver_cut 1-3)

		sed -i -e "s/__version__ = '0.0.0'/__version__ = '${MY_PV}'/" dropbox/dropbox_client.py || die
	fi

	sed -i -e "s/^import mock$/from unittest import mock/" test/unit/test_dropbox_unit.py || die

	distutils-r1_src_prepare
}
