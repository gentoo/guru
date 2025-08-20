# Copyright 2021-2024 Haelwenn (lanodan) Monnier <contact@hacktivis.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = 9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://anongit.hacktivis.me/git/utils-extra.git"
else
	VERIFY_SIG_METHOD=signify
	inherit verify-sig

	SRC_URI="
		https://distfiles.hacktivis.me/releases/utils-extra/${P}.tar.gz
		verify-sig? ( https://distfiles.hacktivis.me/releases/utils-extra/${P}.tar.gz.sign )
	"

	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="Collection of extra tools for Unixes"
HOMEPAGE="https://hacktivis.me/git/utils-extra"
LICENSE="MPL-2.0"
SLOT="0"
IUSE="test static"

RESTRICT="!test? ( test )"

BDEPEND="
	test? (
		dev-libs/atf
		dev-util/kyua
	)
"

if [[ "${PV}" != 9999* ]]
then
	BDEPEND="${BDEPEND} verify-sig? ( sec-keys/signify-keys-lanodan:2025 )"

	VERIFY_SIG_OPENPGP_KEY_PATH="/usr/share/signify-keys/signify-keys-lanodan-2025.pub"

	src_unpack() {
		if use verify-sig; then
			# Too many levels of symbolic links workaround
			cd "${WORKDIR}" || die
			cp "${DISTDIR}/${P}.tar.gz" "${DISTDIR}/${P}.tar.gz.sign" "${WORKDIR}/" || die
			verify-sig_verify_detached "${P}.tar.gz" "${P}.tar.gz.sign"
			unpack "${WORKDIR}/${P}.tar.gz"
			rm "${WORKDIR}/${P}.tar.gz"
		else
			default
		fi
	}
fi

src_configure() {
	export NO_BWRAP=1

	use static && export LDSTATIC="-static-pie"

	./configure PREFIX='/usr'
}

src_install() {
	emake install DESTDIR="${D}"
}
