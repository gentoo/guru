# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="A python API for evaluating language support in the Google Fonts collection"
HOMEPAGE="
	https://github.com/googlefonts/lang
	https://pypi.org/project/gflanguages/
"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

RDEPEND="dev-python/protobuf-python[${PYTHON_USEDEP}]"
DEPEND="
	${RDEPEND}
	>=dev-python/setuptools-scm-4[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/${P}-remove-setuptools_scm-constraint.patch" )

distutils_enable_tests pytest

python_prepare_all() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"
	distutils-r1_python_prepare_all
}
