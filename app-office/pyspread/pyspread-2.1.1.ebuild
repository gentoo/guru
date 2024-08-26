# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit xdg desktop distutils-r1

DESCRIPTION="Pyspread is a non-traditional spreadsheet written in Python"
HOMEPAGE="https://pyspread.gitlab.io"
SRC_URI="https://gitlab.com/pyspread/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# >=dev-python/numpy-2 is incompatible.
# https://gitlab.com/pyspread/pyspread/-/issues/125
RDEPEND="
	>=dev-python/PyQt5-5.10.0[gui,printsupport,svg,widgets,${PYTHON_USEDEP}]
	>=dev-python/markdown2-2.3[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-1.1.1[${PYTHON_USEDEP}]
	<dev-python/numpy-2[${PYTHON_USEDEP}]
	>=dev-python/pyenchant-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.7.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	rm -r "${ED}/usr/pyspread" || die
	doicon "${PN}/share/icons/hicolor/64x64/${PN}.ico"
	doicon "${PN}/share/icons/hicolor/svg/${PN}.svg"
	domenu "${PN}.desktop"
}

src_test() {
	export QT_QPA_PLATFORM=offscreen
	distutils-r1_src_test
}
