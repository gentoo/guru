# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN#openpgp-keys-}"
DESCRIPTION="OpenPGP keys used by Russ Allbery (Eagle)"
HOMEPAGE="https://www.eyrie.org/~eagle/personal/contact.html"
SRC_URI="https://keys.openpgp.org/vks/v1/by-fingerprint/E784364E8DDE7BB370FBD9EAD15D313882004173 -> ${P}.asc"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=( ${A} )

	insinto /usr/share/openpgp-keys
	newins - ${MY_PN}.asc < <(cat "${files[@]/#/${DISTDIR}/}" || die)
}
