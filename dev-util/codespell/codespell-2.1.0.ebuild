# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Check text files for common misspellings"
HOMEPAGE="https://github.com/codespell-project/codespell"
SRC_URI="https://github.com/${PN}-project/${PN}/archive/v${PVR}.tar.gz -> ${P}.tar.gz"

# Code licensed under GPL-2
# Dictionary licensed under CC-BY-SA-3.0
LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

python_prepare_all() {
	# do not depend on pytest-cov
	sed -i -e '/addopts/d' setup.cfg || die

	# This will fail if the package itself
	# is not yet installed
	sed -i -e 's:test_command:_&:' \
		codespell_lib/tests/test_basic.py

	distutils-r1_python_prepare_all
}

distutils_enable_tests pytest
