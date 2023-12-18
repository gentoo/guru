# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_EXT=1
inherit distutils-r1 desktop xdg

DESCRIPTION="An image viewer with vim-like keybindings"
HOMEPAGE="https://karlch.github.io/vimiv-qt/"
SRC_URI="https://github.com/karlch/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND=">=dev-python/PyQt5-5.13.2[${PYTHON_USEDEP}]"
DOCS="README.md AUTHORS"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	doman misc/vimiv.1
	domenu misc/vimiv.desktop
	insinto /usr/share/metainfo
	doins misc/org.karlch.vimiv.qt.metainfo.xml
}
