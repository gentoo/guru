# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Bluespec High Level Hardware Design Language"
HOMEPAGE="https://github.com/B-Lang-org/bsc"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/B-Lang-org/${PN}.git"
else
	SRC_URI=""
	KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"
fi

LICENSE="BSD GPL-3+ MIT"
SLOT="0"

RDEPEND="
	dev-haskell/old-time:0=
	dev-haskell/regex-compat:0=
	dev-haskell/split:0=
	dev-haskell/syb:0=
	dev-lang/tcl
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	dev-haskell/cabal:0=
	dev-lang/ghc:0=
	dev-util/gperf
"

src_install() {
	emake PREFIX="${D}" install
}
