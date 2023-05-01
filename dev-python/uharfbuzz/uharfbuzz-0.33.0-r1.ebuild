# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Streamlined Cython bindings for the HarfBuzz shaping engine"
HOMEPAGE="
	https://pypi.org/project/uharfbuzz/
	https://github.com/harfbuzz/uharfbuzz
"
SRC_URI="$(pypi_sdist_url ${PN} ${PV} .zip)"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"

RDEPEND=">=media-libs/harfbuzz-4.3.0:=[experimental(-)]"
BDEPEND="
	app-arch/unzip
	>=dev-python/cython-0.28.1[${PYTHON_USEDEP}]
	>=dev-python/setuptools-scm-2.1[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${PN}-0.33.0-system-harfbuzz.patch" )

distutils_enable_tests pytest

src_configure() {
	export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
	export USE_SYSTEM_HARFBUZZ=1
}
