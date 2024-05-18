# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/himitsu"
	SLOT="0"
else
	SRC_URI="https://git.sr.ht/~sircmpwn/himitsu/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	SLOT="0/${PV}"
fi

DESCRIPTION="Secret storage system for Unix, suitable for storing passwords, keys, ..."
HOMEPAGE="https://git.sr.ht/~sircmpwn/himitsu"
LICENSE="GPL-3"


DEPEND="
	>=dev-lang/hare-0_pre20231127-r1:=
"
RDEPEND="
	gui-apps/hiprompt-gtk-py
"
BDEPEND="app-text/scdoc"

# binaries are hare-built
QA_FLAGS_IGNORED="usr/bin/.*"

src_configure() {
	sed -i 's;^PREFIX=.*;PREFIX=/usr;' Makefile || die
}
