# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature

DESCRIPTION="Date parsing library designed to parse dates from HTML pages"
HOMEPAGE="https://github.com/scrapinghub/dateparser"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-4"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
"
BDEPEND="test? (
	dev-libs/fastText[python,${PYTHON_USEDEP}]
	dev-python/convertdate[${PYTHON_USEDEP}]
	dev-python/hijri-converter[${PYTHON_USEDEP}]
	dev-python/langdetect[${PYTHON_USEDEP}]
	dev-python/parameterized[${PYTHON_USEDEP}]
)"

EPYTEST_IGNORE=(
	# tests that require network
	tests/test_dateparser_data_integrity.py
)

EPYTEST_DESELECT=(
	# tests that require network
	tests/test_language_detect.py::CustomLangDetectParserTest::test_custom_language_detect_fast_text_{0,1}
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

pkg_postinst() {
	optfeature "calendars support" "dev-python/hijri-converter dev-python/convertdate"
	optfeature "fasttext support" "dev-libs/fastText[python]"
	optfeature "langdetect support" dev-python/langdetect
}
