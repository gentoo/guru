# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..11} ) # no pypy3 support
inherit distutils-r1

DESCRIPTION="Render CLI arguments (sub-commands friendly) defined by argparse module"
HOMEPAGE="https://github.com/tox-dev/sphinx-argparse-cli https://pypi.org/project/sphinx-argparse-cli/"
SRC_URI="https://github.com/tox-dev/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/sphinx-5.3.0[${PYTHON_USEDEP}]
	<dev-python/sphinx-6.1.0[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/hatch-vcs[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
