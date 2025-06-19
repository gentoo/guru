# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg meson

DESCRIPTION="Qt based archiving solution with libarchive backend"
HOMEPAGE="https://gitlab.com/marcusbritanicus/libarchive-qt"
SRC_URI="https://gitlab.com/marcusbritanicus/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-arch/bzip2
	app-arch/libarchive:=
	app-arch/xz-utils
	dev-qt/qtbase:6
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		-Dinstall_static=false
		-Duse_qt_version=qt6
	)
	meson_src_configure
}
