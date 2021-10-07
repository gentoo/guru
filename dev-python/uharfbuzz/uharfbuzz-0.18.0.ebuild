# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS="pyproject.toml"
PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="Streamlined Cython bindings for the HarfBuzz shaping engine"
HOMEPAGE="https://github.com/harfbuzz/uharfbuzz"
SRC_URI="https://github.com/harfbuzz/uharfbuzz/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND=">=media-libs/harfbuzz-2.8.1[experimental(-)]"
DEPEND="
	${RDEPEND}
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${P}-system-harfbuzz.patch" )

distutils_enable_tests pytest

python_prepare_all() {
	distutils-r1_python_prepare_all
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV%_*}"
	export USE_SYSTEM_HARFBUZZ=1
}

python_install() {
	distutils-r1_python_install
	python_optimize "$(python_get_sitedir)/${PN}"
}
