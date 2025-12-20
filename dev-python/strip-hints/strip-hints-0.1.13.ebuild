# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 edo

DESCRIPTION="Function and command-line program to strip Python type hints."
HOMEPAGE="https://pypi.org/project/strip-hints
	https://github.com/abarker/strip-hints"

# Using github tarball due to missing tests in pypi archive
MY_PV="8e55ffaddcc8c8a0fc968729718e0c6abe2b71e9"
SRC_URI="https://github.com/abarker/strip-hints/archive/${MY_PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

python_test() {
	cd test || die
	edo ./run_tests.bash
}
