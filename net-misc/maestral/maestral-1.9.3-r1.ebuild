# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1 xdg

MY_PV=${PV/_rc/.dev}
DESCRIPTION="Maestral is an open-source Dropbox client written in Python"
HOMEPAGE="https://maestral.app"
SRC_URI="https://github.com/samschott/maestral/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}"/${PN}-${MY_PV}

LICENSE="MIT"
SLOT="0"
if [[ ${PV} != *_rc* ]]; then
	KEYWORDS="~amd64"
fi

RDEPEND="
	>=dev-python/click-8.0.2[${PYTHON_USEDEP}]
	>=dev-python/desktop-notifier-3.3.0[${PYTHON_USEDEP}]
	dev-python/dropbox[${PYTHON_USEDEP}]
	>=dev-python/fasteners-0.15[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	>=dev-python/keyring-22.0.0[${PYTHON_USEDEP}]
	>=dev-python/keyrings-alt-3.1.0[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/pathspec-0.5.8[${PYTHON_USEDEP}]
	>=dev-python/Pyro5-5.10[${PYTHON_USEDEP}]
	>=dev-python/requests-2.16.2[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/survey[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	>=dev-python/watchdog-2.0.1[${PYTHON_USEDEP}]
	dev-python/xattr[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/build[${PYTHON_USEDEP}]
"

EPYTEST_DESELECT=(
	# requires dev-python/pytest-benchmark not available for py3.11
	tests/offline/test_clean_local_events.py::test_performance

	# requires systemd
	tests/offline/test_cli.py::test_autostart

	# requires network
	tests/offline/test_main.py::test_check_for_updates

	# may fail if the filesystem does not support xattrs
	# https://bugs.gentoo.org/927982
	tests/offline/utils/test_path.py::test_move_preserves_xattrs
)

distutils_enable_tests pytest
