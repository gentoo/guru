# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1 optfeature

MY_PN="Mastodon.py"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Python wrapper for the Mastodon API"
HOMEPAGE="
	https://pypi.org/project/Mastodon.py/
	https://github.com/halcy/Mastodon.py
"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/blurhash[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/http-ece[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-vcr[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}]
		dev-python/vcrpy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

distutils_enable_sphinx docs

src_prepare() {
	distutils-r1_src_prepare
	rm setup.cfg || die
}

pkg_postinst() {
	optfeature "webpush support" "dev-python/cryptography dev-python/http-ece"
}
