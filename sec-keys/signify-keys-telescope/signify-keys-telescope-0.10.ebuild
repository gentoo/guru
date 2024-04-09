# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${PN#signify-keys-}-${PV}"
DESCRIPTION="Signify keys used to sign telescope releases"
HOMEPAGE="https://telescope.omarpolo.com/"
SRC_URI="https://ftp.omarpolo.com/${MY_P}.pub"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="${PV}"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=( ${A} )

	insinto /usr/share/signify-keys
	newins - ${MY_P}.pub < <(cat "${files[@]/#/${DISTDIR}/}" || die)
}
