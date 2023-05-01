# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Concurrent networking library for Python"
HOMEPAGE="https://github.com/eventlet/eventlet/"
SRC_URI="https://github.com/eventlet/eventlet/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/greenlet[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	test? (	dev-python/pyopenssl[${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}"

distutils_enable_tests nose

python_test() {
	# These tests are also failing upstream
	nosetests -d -v \
		--exclude=test_018b_http_10_keepalive_framing \
		--exclude=test_017_ssl_zeroreturnerror \
		--exclude=test_patcher_existing_locks_locked || die
}
