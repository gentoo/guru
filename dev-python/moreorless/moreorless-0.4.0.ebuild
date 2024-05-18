# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Wrapper to make difflib.unified_diff more fun to use"
HOMEPAGE="https://github.com/thatch/moreorless"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]"
DEPEND="
	${RDEPEND}
	test? ( dev-python/parameterized[${PYTHON_USEDEP}] )
"

distutils_enable_tests unittest

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

python_test() {
	${EPYTHON} -m moreorless.tests -v || die
}
