# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
# TODO re-enable pypi when it is available on there
# <https://github.com/web-push-libs/encrypted-content-encoding/issues/79>
inherit distutils-r1

MY_PN="encrypted-content-encoding"
DESCRIPTION="Encrypted Content Encoding for HTTP"
HOMEPAGE="
	https://pypi.org/project/http-ece/
	https://github.com/web-push-libs/encrypted-content-encoding
"
SRC_URI="https://github.com/web-push-libs/encrypted-content-encoding/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/encrypted-content-encoding-${PV}/python"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_test() {
	epytest -o addopts=
}
