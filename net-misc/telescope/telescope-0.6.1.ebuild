# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="w3m-like browser for Gemini"
HOMEPAGE="https://telescope.omarpolo.com"
SRC_URI="https://github.com/omar-polo/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="!libbsd? ( BSD MIT ) ISC unicode"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+libbsd"

DEPEND="
	dev-libs/imsg-compat
	dev-libs/libevent:=
	dev-libs/libretls:=
	sys-libs/ncurses:=
	libbsd? ( dev-libs/libbsd )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	tc-export_build_env BUILD_CC
	local econf_args=(
		HOSTCC="${BUILD_CC}"
		HOSTCFLAGS="${BUILD_CFLAGS}"
		$(use_with libbsd)
		--with-libimsg
	)

	econf "${econf_args[@]}"
}
