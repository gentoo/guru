# Copyright 1999-2025 Gentoo Authors
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
	dev-libs/libfmt:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-libs/libfmt-9.1.0
	test? ( >=dev-cpp/catch-3.0.1 )
"

src_prepare() {
	default
	# In order to compile smoothly, the minimum version of fmt must be lowered.
	sed -i \
		-e 's/set(fmt_min_version.*)/set(fmt_min_version "9.0")/' \
		"${S}/external/CMakeLists.txt" || die
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
		# fix python unexpected paths QA
		mkdir -p "${D}/$(python_get_sitedir)" || die
		mv "${D}"/usr/pyslang* "${D}/$(python_get_sitedir)" || die
	fi
}
