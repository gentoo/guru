# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Python Data Validation for Humans"
HOMEPAGE="
	https://github.com/kvesteri/validators
	https://pypi.org/project/validators
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=dev-python/decorator-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.4.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
"
#not really required
#	test? (
#		>=dev-python/isort-4.2.2[${PYTHON_USEDEP}]
#	)

distutils_enable_tests pytest

#issues with sphinx.ext.pngmath https://github.com/kvesteri/validators/issues/156
distutils_enable_sphinx docs "<dev-python/sphinx-1.8"
