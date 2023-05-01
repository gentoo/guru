# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 xdg

DESCRIPTION="Maestral is an open-source Dropbox client written in Python"
HOMEPAGE="https://maestral.app"
SRC_URI="https://github.com/samschott/maestral/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/click-8.0.2[${PYTHON_USEDEP}]
	>=dev-python/desktop-notifier-3.3.0[${PYTHON_USEDEP}]
	=dev-python/dropbox-11*[${PYTHON_USEDEP}]
	>=dev-python/fasteners-0.15[${PYTHON_USEDEP}]
	>=dev-python/keyring-22.0.0[${PYTHON_USEDEP}]
	>=dev-python/keyrings-alt-3.1.0[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/pathspec-0.5.8[${PYTHON_USEDEP}]
	>=dev-python/Pyro5-5.10[${PYTHON_USEDEP}]
	>=dev-python/requests-2.16.2[${PYTHON_USEDEP}]
	>=dev-python/sdnotify-0.3.2[${PYTHON_USEDEP}]
	>=dev-python/survey-3.4.3[${PYTHON_USEDEP}]
	<dev-python/survey-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/watchdog-2.0.1[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/build[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-benchmark[${PYTHON_USEDEP}] )
"

EPYTEST_DESELECT=(
	# requires systemd
	tests/offline/test_cli.py::test_autostart

	# requires network
	tests/offline/test_main.py::test_check_for_updates
)

distutils_enable_tests pytest
