# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{13..14} )
inherit cmake python-single-r1

DESCRIPTION="SystemVerilog compiler and language services"
HOMEPAGE="
	https://sv-lang.com
	https://github.com/MikePopoloski/slang
"

SRC_URI="https://github.com/MikePopoloski/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~x86"
IUSE="python test"
REQUIRED_USE=" ${PYTHON_REQUIRED_USE} "
RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	dev-cpp/tomlplusplus
	>=dev-libs/boost-1.87
	>=dev-libs/libfmt-12:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? ( >=dev-cpp/catch-3.16:0 )
	$(python_gen_cond_dep '
		dev-python/nanobind[${PYTHON_USEDEP}]
	')
"

PATCHES=(
	"${FILESDIR}/${PN}-12.1-export-literalbase.patch"
	"${FILESDIR}/${PN}-12.1-nanobind-non-split.patch"
)

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	python_setup
	local mycmakeargs=(
		-D CMAKE_INSTALL_LIBDIR="$(get_libdir)"
		-D BUILD_SHARED_LIBS=ON
		-D SLANG_INCLUDE_PYLIB=$(usex python)
		-D SLANG_INCLUDE_TESTS=$(usex test)
		-D SLANG_USE_MIMALLOC=OFF
		-D SLANG_USE_SYSTEM_FMT=ON
		-D SLANG_USE_SYSTEM_BOOST=ON
		-D SLANG_USE_SYSTEM_TOMLPLUSPLUS=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	# pkg-config consumers do not inherit the CMake target's
	# SLANG_USE_SYSTEM_BOOST definition.
	sed -i 's|^Cflags: |Cflags: -DSLANG_USE_SYSTEM_BOOST |' \
		"${ED}/usr/share/pkgconfig/sv-lang.pc" || die

	if use python; then
		# CMake installs pyslang files flat into /usr/; relocate them into
		# a proper pyslang package directory under site-packages.
		local pydir="${D}/$(python_get_sitedir)/pyslang"
		mkdir -p "${pydir}" || die
		mv "${D}"/usr/pyslang* "${pydir}" || die
		mv "${D}"/usr/__init__.py "${pydir}" || die
		mv "${D}"/usr/py.typed "${pydir}" || die
		mv "${D}"/usr/*.pyi "${pydir}" || die
		python_optimize "${D}/$(python_get_sitedir)"
	fi
}
