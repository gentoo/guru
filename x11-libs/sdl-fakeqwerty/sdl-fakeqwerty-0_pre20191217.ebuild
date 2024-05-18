# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MULTILIB_COMPAT=( abi_x86_{32,64} )

inherit multilib-minimal

DESCRIPTION="Fixes non-QWERTY keyboards on Prison Architect (and maybe other SDL games)"
HOMEPAGE="https://github.com/micolous/sdl-fakeqwerty"
ARCHIVE_VERSION="a79f201903c30e91dc3b4f79c789e25548cf9589"
SRC_URI="https://github.com/micolous/${PN}/archive/${ARCHIVE_VERSION}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${ARCHIVE_VERSION}"

LICENSE="sdl? ( LGPL-2 ) sdl2? ( ZLIB ) xlib? ( ZLIB )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sdl sdl2 xlib"
REQUIRED_USE="|| ( sdl sdl2 xlib )"

DEPEND="
	xlib? ( x11-libs/libX11[${MULTILIB_USEDEP}] )
	sdl? ( >=media-libs/libsdl-1.2[${MULTILIB_USEDEP}] )
	sdl2? ( media-libs/libsdl2[${MULTILIB_USEDEP}] )"
BDEPEND="virtual/pkgconfig"

DOCS=( README.md background.md games )

fakeqwerty_target() {
	case "${MULTILIB_ABI_FLAG}" in
		abi_x86_32)
			echo 'i686'
			;;
		abi_x86_64)
			echo 'amd64'
			;;
		*)
			die "Unsupported ABI FLAG ${MULTILIB_ABI_FLAG}"
			;;
	esac
}

src_prepare() {
	default

	cp -f "${FILESDIR}/Makefile-${PV}" "${S}/Makefile" || die
	multilib_copy_sources
}

multilib_src_compile() {
	local target="$(fakeqwerty_target)"
	CFLAGS="${CFLAGS} $(get_abi_CFLAGS)"
	if use sdl ; then
		emake CFLAGS="${CFLAGS} $(pkg-config --cflags sdl)" "sdl1-hooks-${target}.so" "sdl1-peep-hooks-${target}.so" || die
	fi
	if use sdl2 ; then
		emake CFLAGS="${CFLAGS} $(pkg-config --cflags sdl2)" "sdl2-hooks-${target}.so" || die
	fi
	if use xlib ; then
		emake CFLAGS="${CFLAGS} $(pkg-config --cflags x11)" "xlib-hooks-${target}.so" || die
	fi
}

multilib_src_install() {
	local target="$(fakeqwerty_target)"
	insinto "/usr/$(get_libdir)/sdl-fakeqwerty"
	if use sdl ; then
		newins "sdl1-hooks-${target}.so" "sdl1-hooks.so" || die
		newins "sdl1-peep-hooks-${target}.so" "sdl1-peep-hooks.so" || die
	fi
	if use sdl2 ; then
		newins "sdl2-hooks-${target}.so" "sdl2-hooks.so" || die
	fi
	if use xlib ; then
		newins "xlib-hooks-${target}.so" "xlib-hooks.so" || die
	fi
}
