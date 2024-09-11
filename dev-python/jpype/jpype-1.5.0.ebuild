# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Bridge to allow Python programs full access to Java class libraries"
HOMEPAGE="https://github.com/jpype-project/jpype/"
SRC_URI="https://github.com/jpype-project/jpype/releases/download/v${PV}/JPype1-${PV}.tar.gz "
S="${WORKDIR}/JPype1-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="virtual/jdk"

src_prepare() {
	sed -i "s/'-g0', //g;s/, '-O2'//g"  "${S}"/setupext/platform.py || die
	default
}
