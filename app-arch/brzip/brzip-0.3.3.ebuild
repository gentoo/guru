# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A compression utility based on Brotli algorithm"
HOMEPAGE="https://gitlab.com/ms1888/brzip"
SRC_URI="https://gitlab.com/ms1888/brzip/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-arch/brotli:=
	app-crypt/libmd
	dev-libs/xxhash:="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local emesonargs=(
		-Dlibmd=true
	)

	meson_src_configure
}
