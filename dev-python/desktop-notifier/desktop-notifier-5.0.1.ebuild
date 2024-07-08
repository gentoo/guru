# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="desktop-notifier is a Python library for cross-platform desktop notifications"
HOMEPAGE="
	https://desktop-notifier.readthedocs.io
	https://pypi.org/project/desktop-notifier/
	https://github.com/samschott/desktop-notifier
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/dbus-next[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/build[${PYTHON_USEDEP}]
"

# Tests on pypi are incomplete
# Tests on gh don't work
RESTRICT="test"
