# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Library with helpers for the jsonlines file format"
HOMEPAGE="https://pypi.org/project/jsonlines/"
#SRC_URI="https://files.pythonhosted.org/packages/90/cd/0beacbcfdf9b3af9e7c615cb3dba7ec4be1030d4b283e3c9717e3fd9af3c/jsonlines-1.2.0.tar.gz"
if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/wbolster/jsonlines"
else
	KEYWORDS="~amd64 ~arm64"
#	tests not distributed through pypi mirror
#	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	SRC_URI="https://github.com/wbolster/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
fi
LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="mirror" #overlay, no real issue
RDEPEND="dev-python/attrs[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	sed -r -e "/packages *=/ s|\[[^]]*\]\+||" -i -- setup.py

	distutils-r1_python_prepare_all
}
