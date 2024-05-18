# Copyright 2021-2024 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "$PV" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~lanodan/deblob"
else
	VERIFY_SIG_METHOD=signify
	inherit verify-sig

	SRC_URI="
		https://hacktivis.me/releases/${P}.tar.gz
		verify-sig? ( https://hacktivis.me/releases/${P}.tar.gz.sign )
	"
	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="remove binary executables from a directory"
HOMEPAGE="https://git.sr.ht/~lanodan/deblob"
LICENSE="BSD"
SLOT="0"

DEPEND="
	>=dev-lang/hare-0.24.0:=
"

# built by hare
QA_FLAGS_IGNORED="usr/bin/deblob"

if [[ "${PV}" != "9999" ]]
then
	BDEPEND="${BDEPEND} verify-sig? ( sec-keys/signify-keys-lanodan:2024 )"

	VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/signify-keys/signify-keys-lanodan-2024.pub"

	src_unpack() {
		if use verify-sig; then
			# Too many levels of symbolic links
			cd "${DISTDIR}" || die
			cp ${A} "${WORKDIR}" || die
			cd "${WORKDIR}" || die
			verify-sig_verify_detached "${P}.tar.gz" "${P}.tar.gz.sign"
		fi
		default
	}
fi

src_install() {
	PREFIX="/usr" default
}
