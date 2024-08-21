# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg meson

DESCRIPTION="A Qt based archiving solution with libarchive backend"
HOMEPAGE="https://gitlab.com/marcusbritanicus/libarchive-qt"

if [[ "${PV}" == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/marcusbritanicus/${PN}.git"
else
	SRC_URI="https://gitlab.com/marcusbritanicus/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-v${PV}"
fi

LICENSE="LGPL-3+"
SLOT="0"
IUSE="qt6"

DEPEND="
	app-arch/libarchive:=
	sys-libs/zlib
	!qt6? ( dev-qt/qtcore:5 )
	qt6? ( dev-qt/qtbase:6 )
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		-Dinstall_static=false
		-Duse_qt_version=$(usex qt6 qt6 qt5)
	)
	meson_src_configure
}
