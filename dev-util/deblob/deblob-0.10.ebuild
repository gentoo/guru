# Copyright 2021-2025 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "$PV" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://anongit.hacktivis.me/git/deblob.git"
else
	VERIFY_SIG_METHOD=signify
	inherit verify-sig

	SRC_URI="
		https://distfiles.hacktivis.me/releases/deblob/${P}.tar.gz
		test? ( https://distfiles.hacktivis.me/releases/deblob-test/deblob-test-${PV}.tar.gz )
		verify-sig? (
			https://distfiles.hacktivis.me/releases/deblob/${P}.tar.gz.sign
			test? ( https://distfiles.hacktivis.me/releases/deblob-test/deblob-test-${PV}.tar.gz.sign )
		)
	"
	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="remove binary executables from a directory"
# permalink
HOMEPAGE="https://hacktivis.me/projects/deblob"
LICENSE="BSD"
SLOT="0"

IUSE="test"

RESTRICT="!test? ( test )"

DEPEND="
	>=dev-lang/hare-0.24.2:=
	dev-hare/hare-json
"

# built by hare
QA_FLAGS_IGNORED="usr/bin/deblob"

if [[ "${PV}" != "9999" ]]
then
	BDEPEND="${BDEPEND} verify-sig? ( sec-keys/signify-keys-lanodan:2025 )"

	VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/signify-keys/signify-keys-lanodan-2025.pub"

	src_unpack() {
		if use verify-sig; then
			# Too many levels of symbolic links
			cd "${DISTDIR}" || die
			cp ${A} "${WORKDIR}" || die
			cd "${WORKDIR}" || die

			verify-sig_verify_detached "${P}.tar.gz" "${P}.tar.gz.sign"
			use test && verify-sig_verify_detached "deblob-test-${PV}.tar.gz" "deblob-test-${PV}.tar.gz.sign"
		fi

		default

		if use test; then
			rm -r "${WORKDIR}/${P}/test" || die
			mv "${WORKDIR}/deblob-test-${PV}" "${WORKDIR}/${P}/test" || die
		fi
	}
fi

src_install() {
	PREFIX="/usr" default
}
