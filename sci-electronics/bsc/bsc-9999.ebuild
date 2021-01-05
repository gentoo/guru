# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Bluespec high level hardware design language compiler"
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
IUSE="test"
RESTRICT="!test? ( test )"

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
	sys-devel/autoconf
	sys-devel/bison
	sys-devel/flex
"

PATCHES=(
	"${FILESDIR}"/${PN}-9999-fix-libdir.patch
)

DOCS=( "README.md" "COPYING" )

# We don't want to run it because it will do install by default.
src_compile() { :; }

src_install() {
	emake PREFIX="${ED%/}"/usr LIBDIR="${ED%/}"/usr/$(get_libdir) install
	einstalldocs
}
