# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~autumnull/haredo"
	SLOT="0"
else
	SRC_URI="https://git.sr.ht/~autumnull/haredo/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv"
	SLOT="0/${PV}"
fi

DESCRIPTION="a simple and unix-idiomatic build automator"
HOMEPAGE="https://git.sr.ht/~autumnull/haredo"
LICENSE="WTFPL-2"

DEPEND="dev-lang/hare:="
BDEPEND="app-text/scdoc"

# binaries are hare-built
QA_FLAGS_IGNORED="usr/bin/.*"

src_configure() {
	sed -i 's;^PREFIX=.*;PREFIX=/usr;' Makefile || die
}

src_test() {
	PATH="${S}/bin:$PATH" ./bin/haredo test || die
}
