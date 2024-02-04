# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN#openpgp-keys-}"
DESCRIPTION="OpenPGP keys used to sign Phosh releases"
HOMEPAGE="https://phosh.mobi/"
SRC_URI="https://sources.phosh.mobi/misc/signing-keys/signing-key-${PV}.asc -> ${P}.asc"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=( ${A} )

	insinto /usr/share/openpgp-keys
	newins - ${MY_PN}.asc < <(cat "${files[@]/#/${DISTDIR}/}" || die)
}
