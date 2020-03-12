# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Check text files for common misspellings"
HOMEPAGE="https://github.com/codespell-project/codespell"
SRC_URI="https://github.com/${PN}-project/${PN}/archive/v${PVR}.tar.gz -> ${P}.tar.gz"

# Code licensed under GPL-2
# Dictionary licensed under CC-BY-SA-3.0
LICENSE="GPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest

python_prepare_all() {
	# do not depend on pytest-cov
	sed -i -e '/addopts/d' setup.cfg || die

	# This will fail if the package itself
	# is not yet installed
	sed -i -e 's:test_command:_&:' \
		codespell_lib/tests/test_basic.py

	distutils-r1_python_prepare_all
}
