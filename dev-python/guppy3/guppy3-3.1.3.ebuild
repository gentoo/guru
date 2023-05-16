# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A Python Programming Environment & Heap analysis toolset"
HOMEPAGE="
	https://pypi.org/project/guppy3/
	https://zhuyifei1999.github.io/guppy3/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

python_test() {
	"${EPYTHON}" guppy/heapy/test/test_all.py || die "tests failed"
}
