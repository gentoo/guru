# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="wsgi_intercept installs a WSGI application in place of a real URI for testing"
HOMEPAGE="
	https://pypi.org/project/wsgi-intercept/
	https://github.com/cdent/wsgi-intercept
"

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

RESTRICT="test"
PROPERTIES="test_network"

distutils_enable_tests pytest
