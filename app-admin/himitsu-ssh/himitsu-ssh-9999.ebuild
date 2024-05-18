# Copyright 2022-2024 Gentoo Authors
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
	>=dev-hare/hare-ssh-0.24.0:=
"
DEPEND="
	${RDEPEND}
	>=dev-lang/hare-0.24.0:=
"
BDEPEND="app-text/scdoc"

# All binaries are hare-built
QA_FLAGS_IGNORED=".*"

src_configure() {
	sed -i 's;^PREFIX=.*;PREFIX=/usr;' Makefile || die
}

src_test() {
	# Don't run tests if there's none (which is the case of 0.3)
	grep -r '@test fn' . && emake check
}
