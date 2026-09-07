# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="The Public Suffix List"
HOMEPAGE="https://publicsuffix.org"
SRC_URI="https://publicsuffix.org/list/public_suffix_list.dat -> public_suffix_list-${PV}.dat"

LICENSE="MPL-2.0"
SLOT="0/${PV}"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~mips ~ppc ~ppc64 ~riscv ~sparc ~x86"

src_unpack() {
	mkdir "${WORKDIR}/${P}" || die
	cp "${DISTDIR}/public_suffix_list-${PV}.dat" "${WORKDIR}/${P}"
}

src_install() {
	insinto /usr/share/publicsuffix
	newins "public_suffix_list-${PV}.dat" "public_suffix_list.dat"
}
