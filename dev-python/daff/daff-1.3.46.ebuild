# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} pypy3 )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="The daff can produce and apply tabular diffs"
HOMEPAGE="https://github.com/paulfitz/daff"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~riscv ~sparc ~x86"

python_test() {
	"${EPYTHON}" test/test_example.py || die
}
