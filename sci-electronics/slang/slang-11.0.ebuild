# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{11..14} )
inherit cmake python-single-r1

DESCRIPTION="SystemVerilog compiler and language services"
HOMEPAGE="
	https://sv-lang.com
	https://github.com/MikePopoloski/slang
"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MikePopoloski/${PN}.git"
else
	SRC_URI="https://github.com/MikePopoloski/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~riscv ~x86"
	S="${WORKDIR}/${P}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="python test"
REQUIRED_USE=" ${PYTHON_REQUIRED_USE} "
RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/pybind11-2.10[${PYTHON_USEDEP}]
	')
	>=dev-libs/libfmt-12.1:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-libs/libfmt-12.1
	test? ( >=dev-cpp/catch-3.11 )
"

src_prepare() {
	default
	cmake_src_prepare
}

src_configure() {
	python_setup
	local mycmakeargs=(
		-D CMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-D BUILD_SHARED_LIBS=ON
		-D SLANG_INCLUDE_PYLIB=$(usex python)
		-D SLANG_INCLUDE_TESTS=$(usex test)
		-D SLANG_USE_MIMALLOC=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use python; then
		# CMake installs pyslang files flat into /usr/; relocate them into
		# a proper pyslang package directory under site-packages.
		local pydir="${D}/$(python_get_sitedir)/pyslang"
		mkdir -p "${pydir}" || die
		mv "${D}"/usr/pyslang* "${pydir}" || die
		mv "${D}"/usr/__init__.py "${pydir}" || die
		mv "${D}"/usr/py.typed "${pydir}" || die
		python_optimize "${D}/$(python_get_sitedir)"
	fi
}
