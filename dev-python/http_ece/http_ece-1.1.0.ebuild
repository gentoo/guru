# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )
inherit distutils-r1

MY_PN="encrypted-content-encoding"
DESCRIPTION="Encrypted Content Encoding for HTTP"
HOMEPAGE="
	https://pypi.org/project/http-ece/
	https://github.com/martinthomson/encrypted-content-encoding
"
SRC_URI="https://github.com/martinthomson/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}/python"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]"

distutils_enable_tests nose
