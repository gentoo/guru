# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit desktop distutils-r1

MY_PV=${PV/_rc/.dev}
DESCRIPTION="Maestral is an open-source Dropbox client written in Python"
HOMEPAGE="https://maestral.app"
SRC_URI="https://github.com/samschott/${PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}"/${PN}-${MY_PV}

LICENSE="MIT"
SLOT="0"
if [[ ${PV} != *_rc* ]]; then
	KEYWORDS="~amd64"
fi

RDEPEND="
	>=dev-python/click-8.0.2[${PYTHON_USEDEP}]
	dev-python/markdown2[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/PyQt6[widgets,gui,svg,${PYTHON_USEDEP}]
	>=net-misc/maestral-${PV%_rc*}_rc0[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/build[${PYTHON_USEDEP}]
"

python_install_all() {
	distutils-r1_python_install_all

	domenu src/maestral_qt/resources/maestral.desktop
}
