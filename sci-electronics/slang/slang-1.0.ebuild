# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{8..11} )
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
	dev-libs/libfmt
"

DEPEND="
	${RDEPEND}
"

src_configure() {
	python_setup

	local mycmakeargs=(
		-D CMAKE_INSTALL_LIBDIR="${EPREFIX}/usr/$(get_libdir)"
		-D BUILD_SHARED_LIBS=ON
		-D SLANG_INCLUDE_TESTS=$(usex test)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	# fix libdir path
	if [[ "$(get_libdir)" != "lib" ]] ; then
		mv "${D}"/usr/lib "${D}"/usr/"$(get_libdir)" || die
	fi
	# file collisions of internal fmt
	rm -r "${D}"/usr/include/fmt || die
}
