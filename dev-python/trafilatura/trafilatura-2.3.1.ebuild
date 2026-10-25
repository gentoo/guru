# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 optfeature

DESCRIPTION="Python & Command-line tool to gather text and metadata on the Web"
HOMEPAGE="https://github.com/adbar/trafilatura"
SRC_URI="https://github.com/adbar/trafilatura/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/charset-normalizer[${PYTHON_USEDEP}]
	dev-python/courlan[${PYTHON_USEDEP}]
	dev-python/htmldate[${PYTHON_USEDEP}]
	dev-python/justext[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pycurl[${PYTHON_USEDEP}]
	)
"

EPYTEST_DESELECT=(
	"tests/downloads_tests.py::test_fetch"
	"tests/downloads_tests.py::test_is_live_page"
)

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "curl support" dev-python/pycurl
}
