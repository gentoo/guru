# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Pure-python FIGlet implementation"
HOMEPAGE="
	https://pypi.org/project/pyfiglet/
	https://github.com/pwaller/pyfiglet
"
# no tests in pypi sdist
SRC_URI="https://github.com/pwaller/pyfiglet/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
# bundled fonts: https://src.fedoraproject.org/rpms/python-pyfiglet/blob/rawhide/f/python-pyfiglet.spec
LICENSE+=" BSD HPND MIT NTP contrib? ( all-rights-reserved )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="contrib"

PATCHES=(
	"${FILESDIR}/${P}-fix-test.patch"
)

distutils_enable_tests pytest

src_prepare() {
	mv pyfiglet/fonts-standard pyfiglet/fonts || die
	if use contrib; then
		mv pyfiglet/fonts-contrib/* pyfiglet/fonts || die
	fi
	distutils-r1_src_prepare
}
