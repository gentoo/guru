# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Test python asyncio-based code with ease"
HOMEPAGE="https://github.com/kwarunek/aiounittest"
SRC_URI="https://github.com/kwarunek/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="dev-python/wrapt[${PYTHON_USEDEP}]"

distutils_enable_tests unittest

#distutils_enable_sphinx docs

python_test() {
	eunittest tests
}
