# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Multipart parser for Python 3"
HOMEPAGE="https://github.com/defnull/multipart"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest

PATCHES=(
	# Merged in master but no release since, so backporting it
	"${FILESDIR}/multipart-urlencoded-test.patch"
)

src_test() {
	cd "${S}/test" || die
	distutils-r1_src_test
}
