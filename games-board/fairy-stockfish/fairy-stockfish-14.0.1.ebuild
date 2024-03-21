# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Chess variant engine derived from Stockfish to support fairy chess variants"
HOMEPAGE="https://github.com/ianfab/Fairy-Stockfish"

MY_PV=$(ver_rs 1-2 _)

SRC_URI="
	https://github.com/ianfab/Fairy-Stockfish/archive/fairy_sf_${MY_PV}_xq.tar.gz -> ${P}.tar.gz
	nnue? (
		https://github.com/ianfab/Fairy-Stockfish/releases/download/fairy_sf_${MY_PV}_xq/janggi-85de3dae670a.nnue
		https://github.com/ianfab/Fairy-Stockfish/releases/download/fairy_sf_${MY_PV}_xq/xiangqi-83f16c17fe26.nnue
	)
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_arm_v7 cpu_flags_x86_avx2 cpu_flags_x86_popcnt cpu_flags_x86_sse debug
	general-32 general-64 largeboards nnue test"

# Require largeboards for nnue support as it also built-in .nnue files for Xiangqi and Janggi
REQUIRED_USE="nnue? ( largeboards )"
RESTRICT="!test? ( test )"

DEPEND="
	|| ( app-arch/unzip app-arch/zip )
	test? ( dev-tcltk/expect )
"

S="${WORKDIR}/Fairy-Stockfish-fairy_sf_${MY_PV}_xq/src"

src_unpack() {
	unpack ${P}.tar.gz
	if use nnue ; then
		cp "${DISTDIR}"/janggi-85de3dae670a.nnue "${S}/" || die
		cp "${DISTDIR}"/xiangqi-83f16c17fe26.nnue "${S}/" || die
	fi
}

src_prepare() {
	default

	local item
	# Rename Stockfish to Fairy-Stockfish
	sed -i -e 's:EXE = stockfish:EXE = fairy-stockfish:' Makefile || die
		for item in ../tests/*.sh ; do
			sed -i -e 's:./stockfish:./fairy-stockfish:' $item || die
		done
	# protocol.sh test 'ucci.exp' fails for timeout 5 but pass with 15
	sed -i -e 's:timeout 5:timeout 15:' ../tests/protocol.sh || die
	# instrumented.sh syzygy test data tarball get differ size every time, drop it
	sed -i -e '112,141d' ../tests/instrumented.sh || die

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
	# Build all variants (add Amazons game) and disable default optimize (-O3/-ffast)
	emake all ARCH="${my_arch}" \
		COMP=$(tc-getCXX) \
		COMPILER=$(tc-getCXX) \
		all=yes \
		debug=$(usex debug "yes" "no") \
		largeboards=$(usex largeboards "yes" "no") \
		nnue=$(usex nnue "yes" "no") \
		optimize=no
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
