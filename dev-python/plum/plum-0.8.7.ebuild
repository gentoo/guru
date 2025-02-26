# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

PYTHON_COMPAT=( python3_{11..13} python3_13t )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Pack/Unpack Memory"
HOMEPAGE="https://gitlab.com/dangass/plum"
SRC_URI="https://gitlab.com/dangass/${PN}/-/archive/${PV}/${PN}-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? ( dev-python/baseline[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_IGNORE=(
		# broken test
		# https://gitlab.com/dangass/plum/-/issues/150
		tests/flag/test_flag_invalid.py
	)
	epytest tests
}
