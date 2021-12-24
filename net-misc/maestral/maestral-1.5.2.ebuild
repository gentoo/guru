# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Maestral is an open-source Dropbox client written in Python"
HOMEPAGE="https://maestral.app"
SRC_URI="https://github.com/samschott/maestral/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-python/click-8.0.2[${PYTHON_USEDEP}]
	>=dev-python/desktop-notifier-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/dropbox-sdk-python-10.9.0[${PYTHON_USEDEP}]
	<dev-python/dropbox-sdk-python-12.0.0[${PYTHON_USEDEP}]
	>=dev-python/fasteners-0.15[${PYTHON_USEDEP}]
	>=dev-python/keyring-22.0.0[${PYTHON_USEDEP}]
	>=dev-python/keyrings-alt-3.1.0[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/pathspec-0.5.8[${PYTHON_USEDEP}]
	>=dev-python/Pyro5-5.10[${PYTHON_USEDEP}]
	>=dev-python/requests-2.6.2[${PYTHON_USEDEP}]
	>=dev-python/sdnotify-0.3.2[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/survey-3.4.3[${PYTHON_USEDEP}]
	<dev-python/survey-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/watchdog-2.0.1[${PYTHON_USEDEP}]
	python_targets_python3_8? ( dev-python/importlib_metadata[${PYTHON_USEDEP}] )
"
RDEPEND="${DEPEND}"
BDEPEND="
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"

# Skipped: Requires auth token
RESTRICT=test

distutils_enable_tests setup.py
