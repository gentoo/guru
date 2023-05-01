# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit meson distutils-r1

COMMIT="1e4c5061d328105c4dcfcb6fdbc27ec49b3e9d23"
DESCRIPTION="Python wrapper for Adobe's PostScript autohinter"
HOMEPAGE="
	https://pypi.org/project/psautohint/
	https://github.com/adobe-type-tools/psautohint
"
SRC_URI="
	https://github.com/adobe-type-tools/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	test? (
		https://github.com/adobe-type-tools/${PN}-testdata/archive/${COMMIT}.tar.gz -> ${P}-testdata.gh.tar.gz
	)
"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

DEPEND="media-gfx/libpsautohint"
RDEPEND="
	${DEPEND}
	>=dev-python/fonttools-4.20[${PYTHON_USEDEP}]
	dev-python/fs[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

DOCS=( doc {NEWS,README}.md )

PATCHES=(
	"${FILESDIR}/${PN}-2.3.0-system-libs.patch"
	"${FILESDIR}/${PN}-2.3.0-no-build-library.patch"
)

EPYTEST_DESELECT=(
	tests/integration/test_hint.py::test_hashmap_old_version
	"tests/integration/test_mmhint.py::test_vfotf[tests/integration/data/vf_tests/CJKSparseVar.subset.hinted.otf]"
)

distutils_enable_tests pytest

src_unpack() {
	default

	if use test; then
		mv "${WORKDIR}"/psautohint-testdata-${COMMIT}/* "${S}"/tests/integration/data || die
	fi
}

src_prepare() {
	distutils-r1_src_prepare

	rm -r libpsautohint || die
	mkdir -p libpsautohint/src || die

	rm pytest.ini || die
}

src_configure() {
	export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
}
