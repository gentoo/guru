# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Maestral is an open-source Dropbox client written in Python"
HOMEPAGE="https://maestral.app"
SRC_URI="https://github.com/samschott/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/click-8.0.2[${PYTHON_USEDEP}]
	dev-python/markdown2[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/PyQt5-5.9[widgets,gui,${PYTHON_USEDEP}]
	~net-misc/maestral-${PV}[${PYTHON_USEDEP}]
	python_targets_python3_8? ( dev-python/importlib_resources )
"
RDEPEND="${DEPEND}"
BDEPEND=""

distutils_enable_tests setup.py
