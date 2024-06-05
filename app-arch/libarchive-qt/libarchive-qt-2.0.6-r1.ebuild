# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake

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

LICENSE="LGPL-3"
SLOT="0"
IUSE="static-libs"
RESTRICT="test"

DEPEND="
	app-arch/libarchive[lzma,bzip2,zlib(+)]
	app-arch/lrzip
	app-arch/lzip
	app-arch/lzop
	dev-qt/qtgui:5
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DINSTALL_STATIC=$(usex static-libs)
	)
	cmake_src_configure
}
