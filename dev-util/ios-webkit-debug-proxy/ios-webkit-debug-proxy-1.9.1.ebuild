# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A DevTools proxy for iOS devices"
HOMEPAGE="https://github.com/google/ios-webkit-debug-proxy"
SRC_URI="https://github.com/google/ios-webkit-debug-proxy/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-pda/libimobiledevice:=
	app-pda/libplist
	app-pda/libusbmuxd
	dev-libs/openssl:=
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-dont-build-examples.patch
)

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
