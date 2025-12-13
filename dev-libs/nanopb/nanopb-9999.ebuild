# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit cmake flag-o-matic python-single-r1

DESCRIPTION="plain-C Protocol Buffers for embedded/memory-constrained systems"
HOMEPAGE="https://jpa.kapsi.fi/nanopb/ https://github.com/nanopb/nanopb"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nanopb/nanopb"
else
	SRC_URI="https://github.com/nanopb/nanopb/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="ZLIB"
SLOT="0"
IUSE="+pb-malloc static-libs test"
RESTRICT="!test? ( test )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# nanopb generator requires matching protobuf versions at runtime
# dev-libs/protobuf-29.x requires dev-python/protobuf-5.29.x
# dev-libs/protobuf-3X.Y requires dev-python/protobuf-6.3X.Y
RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		|| (
			( =dev-libs/protobuf-29* =dev-python/protobuf-5*[${PYTHON_USEDEP}] )
			( =dev-libs/protobuf-30* =dev-python/protobuf-6.30*[${PYTHON_USEDEP}] )
			( =dev-libs/protobuf-31* =dev-python/protobuf-6.31*[${PYTHON_USEDEP}] )
			( =dev-libs/protobuf-32* =dev-python/protobuf-6.32*[${PYTHON_USEDEP}] )
			( =dev-libs/protobuf-33* =dev-python/protobuf-6.33*[${PYTHON_USEDEP}] )
		)
	')
"

DEPEND="
	test? ( dev-build/scons )
	${RDEPEND}
"

src_configure() {
	use pb-malloc && append-cppflags "-DPB_ENABLE_MALLOC"
	if is-flagq "-flto" ; then
		append-cflags "-fno-use-linker-plugin -fwhole-program"
	fi
	local mycmakeargs=(
		DBUILD_SHARED_LIBS=$(usex !static-libs)
		DBUILD_STATIC_LIBS=$(usex static-libs)
	)
	cmake_src_configure
}

src_test() {
	cd "${S}"/tests
	scons
}

src_install() {
	cmake_src_install
	python_optimize
}
