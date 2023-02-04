# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="desktop-notifier is a Python library for cross-platform desktop notifications"
HOMEPAGE="
	https://desktop-notifier.readthedocs.io
	https://pypi.org/project/desktop-notifier/
	https://github.com/samschott/desktop-notifier
"
SRC_URI="https://github.com/samschott/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/dbus-next[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/build[${PYTHON_USEDEP}]
"
