# Copyright 2025-2026 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="colorful hex dump (RGB edition)"
HOMEPAGE="https://hacktivis.me/git/xcd-rgb/"

if [[ "${PV}" != "9999" ]]; then
	VERIFY_SIG_METHOD=signify
	inherit verify-sig

	SRC_URI="
		https://distfiles.hacktivis.me/releases/xcd-rgb/${P}.tar.gz
		verify-sig? ( https://distfiles.hacktivis.me/releases/xcd-rgb/${P}.tar.gz.sign )
	"

	KEYWORDS="~amd64 ~arm64 ~x86"
else
	inherit git-r3
	EGIT_REPO_URI="https://anongit.hacktivis.me/git/xcd-rgb.git"
fi

LICENSE="MPL-2.0"
SLOT="0"
IUSE="static"

if [[ "${PV}" != "9999" ]]; then
	BDEPEND="${BDEPEND} verify-sig? ( sec-keys/signify-keys-lanodan:2026 )"

	VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/signify-keys/signify-keys-lanodan-2026.pub"
fi

src_unpack() {
	if [[ "${PV}" != "9999" ]]; then
		if use verify-sig; then
			# Too many levels of symbolic links
			cd "${DISTDIR}" || die
			cp ${A} "${WORKDIR}" || die
			cd "${WORKDIR}" || die

			verify-sig_verify_detached "${P}.tar.gz" "${P}.tar.gz.sign"
			unpack "${P}.tar.gz"
			rm "${P}.tar.gz" "${P}.tar.gz.sign" || die
		else
			default
		fi
	else
		git-r3_src_unpack
	fi
}

src_configure() {
	tc-export CC
	export PREFIX="${EPREFIX}/usr"
	use static && export LDSTATIC=-static
}
