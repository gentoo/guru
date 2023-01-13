# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} pypy3 )

inherit distutils-r1

DESCRIPTION="Streamlined Cython bindings for the HarfBuzz shaping engine"
HOMEPAGE="https://github.com/harfbuzz/uharfbuzz"
SRC_URI="https://github.com/harfbuzz/uharfbuzz/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND=">=media-libs/harfbuzz-4.3.0[experimental(-)]"
DEPEND="
	${RDEPEND}
	>=dev-python/cython-0.28.1[${PYTHON_USEDEP}]
	>=dev-python/setuptools_scm-2.1[${PYTHON_USEDEP}]
	>=dev-python/wheel-0.31[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${PN}-0.33.0-system-harfbuzz.patch" )

distutils_enable_tests pytest

python_prepare_all() {
	distutils-r1_python_prepare_all
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV%_*}"
	export USE_SYSTEM_HARFBUZZ=1
}
