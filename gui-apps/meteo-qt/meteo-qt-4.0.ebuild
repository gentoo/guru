# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 qmake-utils xdg

DESCRIPTION="A system tray application for the weather status"
HOMEPAGE="https://github.com/dglent/meteo-qt"
SRC_URI="https://github.com/dglent/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/pyqt6[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
	')
"
BDEPEND="
	dev-python/pyqt6
	dev-qt/qttools:6[linguist]
"

PATCHES=( "${FILESDIR}"/${PN}-4.0-lrelease.patch )

src_compile() {
	local -x PATH="${EPREFIX}$(qt6_get_libdir)/qt6/libexec:${PATH}"
	distutils-r1_src_compile
}

python_install() {
	mv "${BUILD_DIR}/install$(python_get_sitedir)/usr" "${ED}" || die
	rm -r "${ED}/usr/share/doc" || die

	distutils-r1_python_install
}
