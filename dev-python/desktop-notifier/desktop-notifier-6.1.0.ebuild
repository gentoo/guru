# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="desktop-notifier is a Python library for cross-platform desktop notifications"
HOMEPAGE="
	https://desktop-notifier.readthedocs.io
	https://pypi.org/project/desktop-notifier/
	https://github.com/samschott/desktop-notifier
"
SRC_URI="https://github.com/samschott/desktop-notifier/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/dbus-fast[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/build[${PYTHON_USEDEP}]
	test? (
		dev-python/bidict
		dev-python/pytest-asyncio
	)
"

# Most tests fail, they need some prior setup
EPYTEST_DESELECT=(
	tests/test_api.py::test_send
	tests/test_api.py::test_clear
	tests/test_api.py::test_clear_all
	tests/test_callbacks
	tests/test_sync_api
)
distutils_enable_tests pytest
