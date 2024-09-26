# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P=${P#signify-keys-}
DESCRIPTION="Signify keys used to sign oriole.systems releases"
HOMEPAGE="https://git.oriole.systems"
SRC_URI="https://oriole.systems/release.pub -> ${MY_P}.pub"
S=${WORKDIR}

LICENSE="public-domain"
SLOT="${PV}"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"

src_install() {
	insinto /usr/share/signify-keys
	doins "${DISTDIR}/${MY_P}.pub"
}
