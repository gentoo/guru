# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs multilib-build

DESCRIPTION="CLI program for playing back and rendering SPC files."
HOMEPAGE="https://codeberg.org/jneen/spct"
SRC_URI="https://codeberg.org/jneen/spct/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0/$(ver_cut 1)"
KEYWORDS="~amd64 ~arm64"
IUSE="libspct"

DEPEND="
	media-libs/game-music-emu[${MULTILIB_USEDEP}]
	sys-libs/ncurses:=[${MULTILIB_USEDEP}]
"
BDEPEND="virtual/pkgconfig"
RDEPEND="
	${DEPEND}
"

src_compile() {
	# We use multilib-build directly here because the existing build system is designed with cross-compiles in mind
	# We also specify the platform and arch manually, since otherwise those are determined by `uname` on CHOST
	spct_compile() {
		tc-export CXX
		if multilib_is_native_abi; then
			# only build the binary on the native ABI
			emake VERSION="${PV}" PLATFORM="linux" ARCH="$(tc-arch)" LIBGME_NO_VENDOR=1 bin
		fi

		if use libspct; then
			emake VERSION="${PV}" PLATFORM="linux" ARCH="$(tc-arch)" LIBGME_NO_VENDOR=1 lib
		fi
	}

	multilib_foreach_abi spct_compile
}

src_install() {
	spct_install() {
		if multilib_is_native_abi; then
			# only install the binary on the native ABI
			emake PREFIX="${ED}/usr" LIBDIR="${ED}/usr/$(get_libdir)" VERSION="${PV}" PLATFORM="linux" \
				ARCH="$(tc-arch)" LIBGME_NO_VENDOR=1 install-bin
		fi

		if use libspct; then
			emake PREFIX="${ED}/usr" LIBDIR="${ED}/usr/$(get_libdir)" VERSION="${PV}" PLATFORM="linux" \
				ARCH="$(tc-arch)" LIBGME_NO_VENDOR=1 install-lib
		fi
	}

	multilib_foreach_abi spct_install
	dodoc README.md
}
