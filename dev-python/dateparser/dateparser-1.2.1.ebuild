# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 optfeature pypi

DESCRIPTION="Date parsing library designed to parse dates from HTML pages"
HOMEPAGE="
	https://pypi.org/project/dateparser/
	https://github.com/scrapinghub/dateparser
"

LICENSE="BSD"
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
	dev-python/hijridate[${PYTHON_USEDEP}]
	dev-python/langdetect[${PYTHON_USEDEP}]
	dev-python/parameterized[${PYTHON_USEDEP}]
)"

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme

python_test() {
	# Need to set TZ when testing with gentoo docker images.
	# Their /etc/{timezone,localtime} are inconsistent, which causes
	# to tests to fail.
	local -x TZ=UTC

	local EPYTEST_IGNORE=(
		# tests that require network
		tests/test_dateparser_data_integrity.py
	)
	local EPYTEST_DESELECT=(
		# tests that require network
		tests/test_language_detect.py::CustomLangDetectParserTest::test_custom_language_detect_fast_text_{0,1}
	)

	epytest
}

pkg_postinst() {
	optfeature "calendars support" "dev-python/hijridate dev-python/convertdate"
	optfeature "fasttext support" "dev-libs/fastText[python]"
	optfeature "langdetect support" dev-python/langdetect
}
