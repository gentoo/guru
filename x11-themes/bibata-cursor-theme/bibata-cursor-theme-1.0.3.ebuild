# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="material based cursor theme"
HOMEPAGE="https://github.com/ful1e5/Bibata_Cursor"
SRC_URI="https://github.com/ful1e5/Bibata_Cursor/releases/download/v${PV}/Bibata.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~ppc-aix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
LICENSE="GPL-3"
SLOT="0"
IUSE="+modern original"
REQUIRED_USE="?? ( modern original )"

src_install() {
	local flavors_modern=(
		Bibata-Modern-Amber
		Bibata-Modern-Classic
		Bibata-Modern-Ice
	)
	if use modern; then
		for flavor in ${flavors_modern[@]}; do
			insinto /usr/share/themes/${flavor}
			doins -r ${flavor}/.
		done
	fi
	local flavors_original=(
		Bibata-Original-Amber
		Bibata-Original-Classic
		Bibata-Original-Ice
	)
	if use original; then
		for flavor in ${flavors_original[@]}; do
			insinto /usr/share/themes/${flavor}
			doins -r ${flavor}/.
		done
	fi
}
