# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} pypy3 )

inherit distutils-r1

DESCRIPTION="Hachoir is a Python library to view and edit a binary stream field by field "
HOMEPAGE="
	https://pypi.org/project/hachoir/
	https://github.com/vstinner/hachoir/
"
# use git archives for test data, which is missing in pypi tarballs
SRC_URI="https://github.com/vstinner/hachoir/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest

python_test() {
	local -x SLOW_TESTS=1

	eunittest tests
}
