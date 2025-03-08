# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} python3_13t )

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

RDEPEND="
	dev-libs/protobuf
	${PYTHON_DEPS}
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
		-DBUILD_SHARED_LIBS=$(usex !static-libs)
		-DBUILD_STATIC_LIBS=$(usex static-libs)
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
