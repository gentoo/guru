# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="A fetch written in POSIX shell without any external commands"
HOMEPAGE="https://github.com/sashadelioncourt/fet.sh"

if [[ "${PV}" == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sashadelioncourt/fet.sh.git"
else
	SRC_URI="https://github.com/sashadelioncourt/fet.sh/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/fet.sh-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="ISC"
SLOT="0"

RESTRICT="mirror"

src_install() {
	dobin fet.sh
}
