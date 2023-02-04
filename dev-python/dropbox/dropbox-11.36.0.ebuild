# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1

GH_PN=dropbox-sdk-python

DESCRIPTION="The offical Dropbox SDK for Python"
HOMEPAGE="https://www.dropbox.com/developers"
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

PATCHES=( "${FILESDIR}"/${P}-setuptools-67.patch )

distutils_enable_tests pytest

python_prepare_all() {
	# Don't run tests via setup.py pytest
	sed -i -e "/'pytest-runner.*',/d" setup.py || die
	# this is wrong
	sed -i -e "s/^import mock$/from unittest import mock/" test/unit/test_dropbox_unit.py || die

	# disable tests that need SCOPED_USER_DROPBOX_TOKEN
	mv test/integration/test_dropbox.py test/integration/_test_dropbox.py || die
	sed -i -e "s/\(class\) \(TestClient\)/\\1 _\\2/
	           s/test_NoRedirect_whole_flow/_&/" test/unit/test_dropbox_unit.py || die

	distutils-r1_python_prepare_all
}
