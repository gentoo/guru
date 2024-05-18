# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN#signify-keys-}"
MY_PV="$(ver_cut 1-2)"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="Signify keys used to sign gmid releases"
HOMEPAGE="https://github.com/omar-polo/gmid"
SRC_URI="https://github.com/omar-polo/${MY_PN}/releases/download/${PV}/${MY_P}.pub"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="${MY_PV}"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=( ${A} )

	insinto /usr/share/signify-keys
	newins - ${MY_P}.pub < <(cat "${files[@]/#/${DISTDIR}/}" || die)
}
