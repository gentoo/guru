# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${PN#signify-keys-}-${PV}"
DESCRIPTION="Signify keys used to sign telescope releases"
HOMEPAGE="https://telescope-browser.org/"
SRC_URI="https://ftp.telescope-browser.org/${MY_P}.pub"
S="${WORKDIR}"

LICENSE="public-domain"
SLOT="${PV}"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	local files=( ${A} )

	insinto /usr/share/signify-keys
	newins - ${MY_P}.pub < <(cat "${files[@]/#/${DISTDIR}/}" || die)
}
