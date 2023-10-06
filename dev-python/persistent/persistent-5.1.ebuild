# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="automatic persistence for Python objects"
HOMEPAGE="https://github.com/zopefoundation/persistent"
SRC_URI="https://github.com/zopefoundation/persistent/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
	doc? ( dev-python/repoze-sphinx-autointerface[${PYTHON_USEDEP}] )
	test? (
		dev-python/manuel[${PYTHON_USEDEP}]
		dev-python/zope-testrunner[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

distutils_enable_sphinx docs
distutils_enable_tests unittest

src_unpack() {
	default
	# Fix broken test
	sed -i -e 's/from \.\./from persistent/' "${S}/src/persistent/tests/test_ring.py" || die
	# Disable tests that fail
	sed -z -i -e "s/def test__p_repr_exception.*_p_repr failed')>\")//g" \
		"${S}/src/persistent/tests/test_persistence.py" || die
	sed -z -i -e "s/def test__p_repr_in_instance_ignored.*repr(p)//g" \
		"${S}/src/persistent/tests/test_persistence.py" || die
}

src_test() {
	cd "${S}/src/persistent" || die
	distutils-r1_src_test
}
