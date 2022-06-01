# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="1e4c5061d328105c4dcfcb6fdbc27ec49b3e9d23"
DISTUTILS_IN_SOURCE_BUILD=1
EMESON_SOURCE="${S}/libpsautohint"
PYTHON_COMPAT=( python3_{8..10} )

inherit meson distutils-r1

DESCRIPTION="A standalone version of AFDKO autohinter"
HOMEPAGE="
	https://github.com/adobe-type-tools/psautohint
	https://pypi.org/project/psautohint/
"
SRC_URI="
	https://github.com/adobe-type-tools/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	test? (
		https://github.com/adobe-type-tools/${PN}-testdata/archive/${COMMIT}.tar.gz -> psautohint-testdata-${COMMIT}.tar.gz
	)
"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

# lxml, fs are indirect dependecies
RDEPEND="
	>=dev-python/fonttools-4.20[${PYTHON_USEDEP}]

	dev-python/fs[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/${PN}-bininpath.diff"
	"${FILESDIR}/${PN}-2.3.0-no-build-library.patch"
	"${FILESDIR}/${PN}-2.3.0-no-werror.patch"
)

EPYTEST_DESELECT=(
	tests/integration/test_hint.py::test_hashmap_old_version
	tests/integration/test_hint.py::test_mute_tx_msgs
	tests/integration/test_hint.py::test_type1_supported
	tests/integration/test_mmhint.py::test_vfotf
	tests/integration/test_cli.py::test_multi_outpath
	tests/integration/test_cli.py::test_multi_different_formats
)

distutils_enable_tests pytest

pkg_setup() {
	local _v=$(ver_cut 4)
	_v="$(ver_cut 1-3)${_v:0:1}$(ver_cut 5)"
	export SETUPTOOLS_SCM_PRETEND_VERSION="${_v/p/.post}"
}

src_unpack() {
	default
	mv "${WORKDIR}"/psautohint-testdata-${COMMIT}/* "${S}"/tests/integration/data || die
}

python_prepare_all() {
	# error: unrecognized arguments: -n
	sed "/^  /d" -i pytest.ini || die

	distutils-r1_python_prepare_all
}

src_configure() {
	MESON_BUILD_DIR="${WORKDIR}/${P}-build"
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
	epytest
}
