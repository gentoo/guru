# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

PYTHON_COMPAT=( python3_{8..10} pypy3 )

inherit distutils-r1

DESCRIPTION="wsgi_intercept installs a WSGI application in place of a real URI for testing"
HOMEPAGE="https://pypi.org/project/wsgi-intercept"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/httplib2[${PYTHON_USEDEP}]
		>=dev-python/requests-2.0.1[${PYTHON_USEDEP}]
		>=dev-python/urllib3-1.11.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
