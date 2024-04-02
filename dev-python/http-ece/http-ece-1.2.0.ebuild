# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

MY_PN="encrypted-content-encoding"
DESCRIPTION="Encrypted Content Encoding for HTTP"
HOMEPAGE="
	https://pypi.org/project/http-ece/
	https://github.com/web-push-libs/encrypted-content-encoding
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# dev-python/nose removed from ::gentoo
RESTRICT="test"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]"

# distutils_enable_tests nose
