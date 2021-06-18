# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="1e4c5061d328105c4dcfcb6fdbc27ec49b3e9d23"
DISTUTILS_IN_SOURCE_BUILD=1
EMESON_SOURCE="${S}/libpsautohint"
PYTHON_COMPAT=( python3_8 )

inherit meson distutils-r1

SRC_URI="
	https://github.com/adobe-type-tools/psautohint/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	test? (
		https://github.com/adobe-type-tools/psautohint-testdata/archive/${COMMIT}.tar.gz -> psautohint-testdata-${COMMIT}.tar.gz
	)
"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="A standalone version of AFDKO autohinter"
HOMEPAGE="https://github.com/adobe-type-tools/psautohint"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND=">=dev-python/fonttools-4.20[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-bininpath.diff"
	"${FILESDIR}/${P}-no-build-library.patch"
	"${FILESDIR}/${P}-no-werror.patch"
)

distutils_enable_tests pytest

pkg_setup() {
	local _v=$(ver_cut 4)
	_v="$(ver_cut 1-3)${_v:0:1}$(ver_cut 5)"
	export SETUPTOOLS_SCM_PRETEND_VERSION="${_v/p/.post}"
	MESON_BUILD_DIR="${WORKDIR}/${P}-build"
}

src_unpack() {
	default
	if [ -d "${WORKDIR}/psautohint-testdata-${COMMIT}" ]; then
		mv "${WORKDIR}/psautohint-testdata-${COMMIT}"/* "${S}/tests/integration/data/" || die
	fi
}

src_configure() {
	BUILD_DIR="${MESON_BUILD_DIR}" meson_src_configure
	distutils-r1_src_configure
}

src_compile() {
	BUILD_DIR="${MESON_BUILD_DIR}" meson_src_compile
	distutils-r1_src_compile
}

python_compile() {
	esetup.py build_py build_ext --library-dirs "${MESON_BUILD_DIR}"
}

src_install() {
	BUILD_DIR="${MESON_BUILD_DIR}" meson_src_install
	distutils-r1_src_install
	dodoc doc/*
}

python_test() {
	local -x PATH="${BUILD_DIR}/test/scripts:${MESON_BUILD_DIR}l:${PATH}"
	local -x LD_LIBRARY_PATH="${MESON_BUILD_DIR}"
	distutils_install_for_testing
	epytest -vv \
		--deselect tests/integration/test_hint.py::test_hashmap_old_version \
		|| die
}
