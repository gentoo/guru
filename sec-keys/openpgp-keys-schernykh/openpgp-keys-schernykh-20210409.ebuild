# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="OpenPGP keys used to sign P2Pool releases"
HOMEPAGE="https://p2pool.io/"
SRC_URI="https://p2pool.io/SChernykh.asc"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=(${A})
	insinto /usr/share/openpgp-keys
	newins - SChernykh.asc < <(cat "${files[@]/#/${DISTDIR}/}")
}
