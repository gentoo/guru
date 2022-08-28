# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Bluespec high level hardware design language compiler"
HOMEPAGE="https://github.com/B-Lang-org/bsc"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/B-Lang-org/bsc.git"
	inherit git-r3
else
	EGIT_COMMIT="69dee0667e51108832b685511e9aa631cca1e83a"
	# Using SRC_URI here will failed because this repo uses git submodules.
	# SRC_URI="https://github.com/B-Lang-org/bsc/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	# S="${WORKDIR}/bsc-${EGIT_COMMIT}"
	# Waiting for https://github.com/B-Lang-org/bsc/issues/85
	EGIT_REPO_URI="https://github.com/B-Lang-org/bsc.git"
	# This inherit git-r3 will removed after upstream finished.
	inherit git-r3

	KEYWORDS="~amd64 ~x86"
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
	test? (
		dev-util/dejagnu
		sci-electronics/systemc
		sys-process/time
	)
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
	"${FILESDIR}"/${PN}-0_pre20210106-fix-libdir.patch
	"${FILESDIR}"/${PN}-0_pre20210106-fix-wrapper.patch
)

DOCS=( "README.md" "COPYING" )

# We don't want to run it because it will do install by default.
src_compile() { :; }

src_install() {
	emake PREFIX="${ED%/}"/usr LIBDIR="${ED%/}"/usr/$(get_libdir) install
	emake -C src/comp PREFIX="${ED%/}"/usr LIBDIR="${ED%/}"/usr/$(get_libdir) install-extra
	einstalldocs
}
