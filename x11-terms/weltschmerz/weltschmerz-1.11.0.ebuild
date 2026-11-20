# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION="0.56"

VERIFY_SIG_METHOD="signify"
inherit meson vala verify-sig

DESCRIPTION="A terminal emulator in Vala"
HOMEPAGE="https://oriole.systems/posts/weltschmerz"
SRC_URI="
	https://git.oriole.systems/${PN}/snapshot/${P}.tar.gz
	verify-sig? (
		https://git.oriole.systems/weltschmerz/snapshot/${P}.tar.gz.asc
			-> ${P}.sha.sig
	)
"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="$(vala_depend)
	sys-devel/gettext
	verify-sig? ( sec-keys/signify-keys-oriole-systems )"

DEPEND="
	>=x11-libs/vte-0.78.3:2.91[vala]"
RDEPEND="${DEPEND}"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/signify-keys/oriole-systems-20240330.pub"

src_unpack() {
	if use verify-sig; then
		cp "${DISTDIR}"/${P}.{sha.sig,tar.gz} "${WORKDIR}" || die
		verify-sig_verify_signed_checksums \
			${P}.sha.sig sha256 ${P}.tar.gz
	fi
	default
}

src_prepare() {
	default

	vala_setup
}
