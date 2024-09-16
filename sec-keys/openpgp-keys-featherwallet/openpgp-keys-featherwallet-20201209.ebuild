# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="302e585af45011359a60151d3b79812cf05549e8"

DESCRIPTION="OpenPGP keys used to sign Feather Wallet releases"
HOMEPAGE="https://featherwallet.org/download/"
SRC_URI="https://raw.githubusercontent.com/feather-wallet/feather/${COMMIT}/utils/pubkeys/featherwallet.asc -> ${P}.asc"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=( ${A} )
	insinto /usr/share/openpgp-keys
	newins - featherwallet.asc < <(cat "${files[@]/#/${DISTDIR}/}")
}
