# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenPGP keys used by Alexander Epaneshnikov"
HOMEPAGE="https://github.com/alex19ep https://keybase.io/alex19ep"
SRC_URI="https://keybase.io/alex19ep/pgp_keys.asc?fingerprint=6c7f7f22e0152a6fd5728592dad6f3056c897266 -> ${P}.asc"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=( ${A} )

	insinto /usr/share/openpgp-keys
	newins - aepaneshnikov.asc < <(cat "${files[@]/#/${DISTDIR}/}" || die)
}
