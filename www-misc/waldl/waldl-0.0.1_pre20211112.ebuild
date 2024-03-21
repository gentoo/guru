# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Browse and download wallpapers from wallhaven.cc using sxiv"
HOMEPAGE="https://github.com/pystardust/waldl"
GIT_COMMIT="727640c1583cf627c075db7239e09e7bbdfecf17"
SRC_URI="https://github.com/pystardust/waldl/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	app-misc/jq
	media-gfx/sxiv
	net-misc/curl
	x11-libs/libnotify
	x11-misc/dmenu
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${GIT_COMMIT}/"

PATCHES=(
	"${FILESDIR}/waldl-0.0.1-customize.patch"
)

DOCS=( README.md "${FILESDIR}/waldlrc.example" )

src_install() {
	einstalldocs
	dobin waldl
}
