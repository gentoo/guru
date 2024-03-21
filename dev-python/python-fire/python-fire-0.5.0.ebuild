# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )
inherit distutils-r1

DESCRIPTION="Library for automatically generating command line interfaces from Python objects"
HOMEPAGE="https://pypi.org/project/python-fire/"
SRC_URI="https://github.com/google/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/six
	dev-python/termcolor
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest
