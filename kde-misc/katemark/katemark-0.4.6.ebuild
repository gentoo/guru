# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A Kate Markdown side panel plugin (katdown fork)"
HOMEPAGE="https://github.com/obook/katemark"
SRC_URI="https://github.com/obook/katemark/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="test"

RESTRICT="!test? ( test )"

RDEPEND="
	dev-qt/qtbase[gui,network,widgets]
	dev-qt/qtwebengine
	kde-frameworks/kconfig
	kde-frameworks/kcoreaddons
	kde-frameworks/ki18n
	kde-frameworks/ktexteditor
	kde-frameworks/kwidgetsaddons
	kde-frameworks/kxmlgui
	kde-frameworks/syntax-highlighting
"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

pkg_pretend() {
	if ! has_version dev-qt/qtwebengine ; then
		einfo "It's recommended to install dev-qt/qtwebengine from Gentoo's binhost [1] in advance"
		einfo "due to its lengthy compilation time and substantial memory requirements during the process."
		einfo "[1] https://wiki.gentoo.org/wiki/Gentoo_Binary_Host_Quickstart"
	fi
}

src_test() {
	local -x QT_QPA_PLATFORM=offscreen
	cmake_src_test
}
