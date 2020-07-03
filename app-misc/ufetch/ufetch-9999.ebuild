# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://gitlab.com/jschx/${PN}"
case "${PV}" in
	"9999")
		inherit git-r3
		;;
	*)
		P0="${PN}-v${PV}"
		SRC_URI="${EGIT_REPO_URI}/-/archive/v${PV}/${P0}.tar.gz -> ${P}.tar.gz"
		S="${WORKDIR}/${P0}"
esac

DESCRIPTION="Tiny system info for Unix-like operating systems"
HOMEPAGE="${EGIT_REPO_URI}"
LICENSE="ISC"

SLOT="0"
KEYWORDS=""

src_install() {
	exeinto /usr/bin &&
		newexe ufetch-gentoo ufetch ||
		die "Failed to install ufetch"
}
