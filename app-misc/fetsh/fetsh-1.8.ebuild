# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A fetch written in POSIX shell without any external commands"
HOMEPAGE="https://github.com/6gk/fet.sh"

case "${PV}" in
	9999)
		inherit git-r3
		EGIT_REPO_URI="https://github.com/6gk/fet.sh.git"
		;;
	*)
		P0="fet.sh-${PV}"
		SRC_URI="https://github.com/6gk/fet.sh/archive/v${PV}.tar.gz -> ${P0}.tar.gz"
		S="${WORKDIR}/${P0}"
		KEYWORDS="~amd64"
esac

LICENSE="ISC"
SLOT="0"

RESTRICT="mirror"

src_install() {
	dobin fet.sh
}
