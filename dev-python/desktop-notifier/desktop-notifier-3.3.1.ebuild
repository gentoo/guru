# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="desktop-notifier is a Python library for cross-platform desktop notifications"
HOMEPAGE="https://github.com/altdesktop/python-dbus-next"
SRC_URI="https://github.com/samschott/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/python-dbus-next[${PYTHON_USEDEP}]
	python_targets_python3_8? ( dev-python/importlib_resources )
"
RDEPEND="${DEPEND}"
BDEPEND=""

distutils_enable_tests setup.py
