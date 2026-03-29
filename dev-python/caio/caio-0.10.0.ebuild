# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Asynchronous file IO for Linux MacOS or Windows"
HOMEPAGE="
	https://github.com/mosquito/caio
	https://pypi.org/project/caio/
"
SRC_URI="https://github.com/mosquito/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

EPYTEST_PLUGINS=( aiomisc-pytest )
distutils_enable_tests pytest

python_test() {
	rm -rf caio || die
	epytest
}
