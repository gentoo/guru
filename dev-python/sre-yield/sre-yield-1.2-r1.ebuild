# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Python module to generate regular all expression matches"
HOMEPAGE="
	https://pypi.org/project/sre-yield/
	https://github.com/sre-yield/sre-yield
"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64"
SLOT="0"

distutils_enable_tests unittest
