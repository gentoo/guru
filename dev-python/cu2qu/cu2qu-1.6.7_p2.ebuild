# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature pypi

DESCRIPTION="Cubic-to-quadratic bezier curve conversion"
HOMEPAGE="
	https://pypi.org/project/cu2qu/
	https://github.com/googlefonts/cu2qu
"
SRC_URI="$(pypi_sdist_url "${PN}" "$(pypi_translate_version "${PV}")" .zip)"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	>=dev-python/fonttools-3.32[${PYTHON_USEDEP}]
	<dev-python/fs-3[${PYTHON_USEDEP}]
"
BDEPEND="
	app-arch/unzip
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_configure() {
	CU2QU_WITH_CYTHON=1
}

pkg_postinst() {
	optfeature "cli support" dev-python/defcon
}
