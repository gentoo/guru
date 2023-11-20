# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VERIFY_SIG_METHOD="signify"
inherit toolchain-funcs verify-sig

DESCRIPTION="w3m-like browser for Gemini"
HOMEPAGE="https://telescope.omarpolo.com"
SRC_URI="https://github.com/omar-polo/${PN}/releases/download/${PV}/${P}.tar.gz
	verify-sig? ( https://github.com/omar-polo/${PN}/releases/download/${PV}/SHA256.sig -> ${P}.sha.sig )"

LICENSE="!libbsd? ( BSD MIT ) ISC unicode"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+libbsd"

DEPEND="
	dev-libs/imsg-compat
	dev-libs/libbsd
	dev-libs/libevent:=
	dev-libs/libretls:=
	sys-libs/ncurses:=
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	verify-sig? ( sec-keys/signify-keys-telescope:$(ver_cut 1-2) )
"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/signify-keys/${PN}-$(ver_cut 1-2).pub"

src_unpack() {
	if use verify-sig; then
		# Too many levels of symbolic links
		cp "${DISTDIR}"/${P}.{sha.sig,tar.gz} "${WORKDIR}" || die
		cd "${WORKDIR}" || die
		verify-sig_verify_signed_checksums \
			${P}.sha.sig sha256 ${P}.tar.gz
	fi
	default
}

src_configure() {
	tc-export_build_env BUILD_CC
	local econf_args=(
		HOSTCC="${BUILD_CC}"
		HOSTCFLAGS="${BUILD_CFLAGS}"
		--with-libbsd
		--with-libimsg
	)

	econf "${econf_args[@]}"
}
