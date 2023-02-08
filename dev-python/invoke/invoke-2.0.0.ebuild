# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

DESCRIPTION="Pythonic task execution"
HOMEPAGE="https://github.com/pyinvoke/invoke https://pypi.org/project/invoke/"
SRC_URI="https://github.com/pyinvoke/invoke/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

src_prepare(){
	rm -r ./invoke/vendor/yaml2
	eapply_user
}
