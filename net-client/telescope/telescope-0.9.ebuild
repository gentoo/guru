# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VERIFY_SIG_METHOD="signify"
inherit toolchain-funcs verify-sig

DESCRIPTION="w3m-like browser for Gemini"
HOMEPAGE="https://telescope.omarpolo.com"
SRC_URI="https://ftp.omarpolo.com/${P}.tar.gz
	verify-sig? ( https://ftp.omarpolo.com/${P}.tar.gz.sha256.sig )"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="unicode"

DEPEND="
	dev-libs/libbsd
	dev-libs/libgrapheme:=
	dev-libs/libretls:=
	sys-libs/ncurses:=
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-alternatives/yacc
	virtual/pkgconfig
	verify-sig? ( sec-keys/signify-keys-telescope:$(ver_cut 1-2) )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/signify-keys/${PN}-$(ver_cut 1-2).pub"

src_unpack() {
	if use verify-sig; then
		# Too many levels of symbolic links
		cp "${DISTDIR}"/${P}.tar.gz{,.sha256.sig} "${WORKDIR}" || die
		cd "${WORKDIR}" || die
		verify-sig_verify_signed_checksums \
			${P}.tar.gz.sha256.sig sha256 ${P}.tar.gz
	fi
	default
}

src_configure() {
	tc-export_build_env BUILD_CC
	local econf_args=(
		HOSTCC="${BUILD_CC}"
		HOSTCFLAGS="${BUILD_CFLAGS}"
		--with-libbsd
		--without-libimsg
	)

	econf "${econf_args[@]}"
}
