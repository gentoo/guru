# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/himitsu-ssh"
else
	SRC_URI="https://git.sr.ht/~sircmpwn/himitsu-ssh/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="SSH integration for Himitsu"
HOMEPAGE="https://git.sr.ht/~sircmpwn/himitsu-ssh"
LICENSE="GPL-3"
SLOT="0"


RDEPEND="
	app-admin/himitsu:=
	dev-hare/hare-ssh:=
"
DEPEND="
	${RDEPEND}
	dev-lang/hare:=
"
BDEPEND="app-text/scdoc"

# All binaries are hare-built
QA_FLAGS_IGNORED=".*"

src_configure() {
	sed -i 's;^PREFIX=.*;PREFIX=/usr;' Makefile || die
}
