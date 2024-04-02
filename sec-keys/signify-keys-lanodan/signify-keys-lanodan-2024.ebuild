# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VERIFY_SIG_METHOD=signify
inherit verify-sig

MY_PREV_PV="2023"
DESCRIPTION="Signify keys used by Haelwenn (lanodan) Monnier"
HOMEPAGE="https://hacktivis.me/releases/signify/"
SRC_URI="
	https://hacktivis.me/releases/signify/${PV}.pub -> ${P}.pub
	verify-sig? ( https://hacktivis.me/releases/signify/${PV}.pub.${MY_PREV_PV}.sig -> ${P}.pub.${MY_PREV_PV}.sig )
"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="${PV}"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~ppc ~ppc64 ~riscv ~sparc ~x86"

BDEPEND="verify-sig? ( sec-keys/signify-keys-lanodan:${MY_PREV_PV} )"

VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/signify-keys/${PN}-${MY_PREV_PV}.pub"

src_unpack() {
	if use verify-sig; then
		# Too many levels of symbolic links
		cd "${DISTDIR}" || die
		cp ${A} "${WORKDIR}" || die
		cd "${WORKDIR}" || die
		verify-sig_verify_detached "${P}.pub" "${P}.pub.${MY_PREV_PV}.sig"
	fi
	default
}

src_install() {
	insinto /usr/share/signify-keys
	doins "${P}.pub"
}
