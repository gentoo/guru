# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="$(ver_rs 1 -)"
DESCRIPTION="Signify keys used by Haelwenn (lanodan) Monnier"
HOMEPAGE="https://hacktivis.me/releases/signify/"
SRC_URI="https://hacktivis.me/releases/signify/${MY_PV}.pub -> ${PN}-${MY_PV}.pub"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="${MY_PV}"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=( ${A} )

	insinto /usr/share/signify-keys
	newins - ${P}.pub < <(cat "${files[@]/#/${DISTDIR}/}" || die)
}
