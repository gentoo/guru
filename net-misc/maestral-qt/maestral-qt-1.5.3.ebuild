# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_PEP517=setuptools

inherit desktop distutils-r1

DESCRIPTION="Maestral is an open-source Dropbox client written in Python"
HOMEPAGE="https://maestral.app"
SRC_URI="https://github.com/samschott/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/click-8.0.2[${PYTHON_USEDEP}]
	dev-python/markdown2[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/PyQt5-5.9[widgets,gui,${PYTHON_USEDEP}]
	~net-misc/maestral-${PV}[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/importlib_resources[${PYTHON_USEDEP}]' python3_8)
"
BDEPEND="
	dev-python/build[${PYTHON_USEDEP}]
"

distutils_enable_tests setup.py

python_install_all()
{
	domenu src/maestral_qt/resources/maestral.desktop
}
