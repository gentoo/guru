# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A python API for evaluating coverage of glyph sets in font projects"
HOMEPAGE="
	https://github.com/googlefonts/glyphsets
	https://pypi.org/project/glyphsets/
"
SRC_URI="https://github.com/googlefonts/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

#ufoLib2 is an indirect dependency
RDEPEND="
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/ufoLib2[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/setuptools-scm-4[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${PN}-0.5.0-remove-setuptools_scm.constraint.patch" )

python_prepare_all() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"
	distutils-r1_python_prepare_all
}
