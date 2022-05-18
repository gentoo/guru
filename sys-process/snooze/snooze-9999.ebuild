# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Run a command at a particular time"
HOMEPAGE="https://github.com/leahneukirchen/${PN}"
if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

LICENSE="CC0-1.0"
SLOT="0"

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	dodoc {README,NEWS}.md
}
