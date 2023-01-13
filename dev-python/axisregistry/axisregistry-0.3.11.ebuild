# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A Python API to access data from the Google Fonts variable fonts Axis Registry"
HOMEPAGE="
	https://github.com/googlefonts/axisregistry
	https://pypi.org/project/axisregistry/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="
	dev-python/fonttools[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	>=dev-python/setuptools_scm-6[${PYTHON_USEDEP}]
	test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/black[${PYTHON_USEDEP}]
		dev-python/isort[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"
	distutils-r1_python_prepare_all
}
