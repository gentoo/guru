# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN#openpgp-keys-}"
DESCRIPTION="OpenPGP keys used to sign Mullvad Browser releases"
HOMEPAGE="https://github.com/mullvad/mullvad-browser/ https://mullvad.net/"
SRC_URI="https://openpgpkey.torproject.org/.well-known/openpgpkey/torproject.org/hu/kounek7zrdx745qydx6p59t9mqjpuhdf -> ${P}.asc"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=( ${A} )

	insinto /usr/share/openpgp-keys
	newins - ${MY_PN}.asc < <(cat "${files[@]/#/${DISTDIR}/}" || die)
}
