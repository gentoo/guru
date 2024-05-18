# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools

DESCRIPTION="cow client for netrek"
HOMEPAGE="https://netrek.org"
SRC_URI="https://github.com/quozl/netrek-client-cow/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/netrek-client-cow-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# upstream has a file named check that is unrelated to tests
RESTRICT="test"

RDEPEND="
	media-libs/imlib2
	media-libs/libsdl
	media-libs/sdl-mixer
	x11-base/xorg-proto
	x11-libs/libX11
	x11-libs/libXxf86vm
	x11-libs/libXmu
"
DEPEND="
	${RDEPEND}
"

src_prepare() {
	default
	./autogen.sh
	eautoreconf
}

src_install() {
	dobin netrek-client-cow
}

PATCHES=(
	"${FILESDIR}/${P}-autoupdate.patch"
)
