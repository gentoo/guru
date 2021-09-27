# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Chess variant engine derived from Stockfish to support fairy chess variants"
HOMEPAGE="https://github.com/ianfab/Fairy-Stockfish"

MY_PV=$(ver_rs 1 _)

SRC_URI="
	https://github.com/ianfab/Fairy-Stockfish/archive/fairy_sf_${MY_PV}.tar.gz -> ${P}.tar.gz
	test? ( https://api.github.com/repos/niklasf/python-chess/tarball/9b9aa13f9f36d08aadfabff872882f4ab1494e95 -> ${PN}-test-syzygy-${PV}.tar.gz )
"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_arm_v7 cpu_flags_x86_avx2 cpu_flags_x86_popcnt cpu_flags_x86_sse allvariants debug
	general-32 general-64 largeboards +optimize python test"

RESTRICT="!test? ( test )"

DEPEND="
	|| ( app-arch/unzip app-arch/zip )
	test? ( dev-tcltk/expect )
"
RDEPEND=""

S="${WORKDIR}/Fairy-Stockfish-fairy_sf_${PV}/src"

src_prepare() {
	default

	local item
	use test && { mv -T ../../niklasf-python-chess-9b9aa13 ../tests/syzygy || die; }
	# Rename Stockfish to Fairy-Stockfish
	sed -i -e 's:EXE = stockfish:EXE = fairy-stockfish:' Makefile || die
		for item in ../tests/*.sh ; do
			sed -i -e 's:./stockfish:./fairy-stockfish:' $item || die
		done
	# protocol.sh test 'ucci.exp' fails for timeout 5 but pass with 15
	sed -i -e 's:timeout 5:timeout 15:' ../tests/protocol.sh || die
	# instrumented.sh syzygy test runs infinitly with USE="largeboards", drop it
	use largeboards && { sed -i -e '112,141d' ../tests/instrumented.sh || die; }

	# prevent pre-stripping
	sed -e 's:-strip $(BINDIR)/$(EXE)::' -i Makefile \
		|| die 'failed to disable stripping in the Makefile'
}

src_compile() {
	local my_arch

	# generic unoptimized first
	use general-32 && my_arch=general-32
	use general-64 && my_arch=general-64

	# x86
	use x86 && my_arch=x86-32-old
	use cpu_flags_x86_sse && my_arch=x86-32

	# amd64
	use amd64 && my_arch=x86-64
	use cpu_flags_x86_popcnt && my_arch=x86-64-modern

	# both bmi2 and avx2 are part of hni (haswell new instructions)
	use cpu_flags_x86_avx2 && my_arch=x86-64-bmi2

	# other architectures
	use cpu_flags_arm_v7 && my_arch=armv7
	use ppc && my_arch=ppc
	use ppc64 && my_arch=ppc64

	# Skip the "build" target and use "all" instead to avoid the config
	# sanity check (which would throw a fit about our compiler). There's
	# a nice hack in the Makefile that overrides the value of CXX with
	# COMPILER to support Travis CI and we abuse it to make sure that we
	# build with our compiler of choice.
	emake all ARCH="${my_arch}" \
		COMP=$(tc-getCXX) \
		COMPILER=$(tc-getCXX) \
		all=$(usex allvariants "yes" "no") \
		debug=$(usex debug "yes" "no") \
		largeboards=$(usex largeboards "yes" "no")
		optimize=$(usex optimize "yes" "no")
}

src_test() {
	../tests/instrumented.sh || die
	../tests/perft.sh || die
	../tests/protocol.sh || die
	../tests/reprosearch.sh || die
	../tests/signature.sh || die
}

src_install() {
	dobin "${PN}"
	dodoc ../AUTHORS ../README.md
}
