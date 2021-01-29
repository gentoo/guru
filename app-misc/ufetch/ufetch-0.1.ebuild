# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

case "${PV}" in
	"9999")
		inherit git-r3
		EGIT_REPO_URI="https://gitlab.com/jschx/ufetch.git"
		;;
	*)
		P0="${PN}-v${PV}"
		SRC_URI="https://gitlab.com/jschx/ufetch/-/archive/v${PV}/${P0}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/${P0}"
		KEYWORDS="~amd64 ~x86"
esac

DESCRIPTION="Tiny system info for Unix-like operating systems"
HOMEPAGE="https://gitlab.com/jschx/ufetch"
LICENSE="ISC"

RESTRICT="mirror test"

SLOT="0"

src_install() {
	exeinto /usr/bin &&
		newexe ufetch-gentoo ufetch ||
		die "Failed to install ufetch"
}
