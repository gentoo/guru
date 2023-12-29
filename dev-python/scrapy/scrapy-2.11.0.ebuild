# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="A high-level Web Crawling and Web Scraping framework"
HOMEPAGE="https://scrapy.org/"
SRC_URI="https://github.com/scrapy/scrapy/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT=0
KEYWORDS="~amd64"

# The 'PyDispatcher>=2.0.5' distribution was not found and is required by Scrapy
# https://bugs.gentoo.org/684734
RDEPEND="${PYTHON_DEPS}
	dev-python/cssselect[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	<dev-python/priority-2.0.0[${PYTHON_USEDEP}]
	dev-python/h2[${PYTHON_USEDEP}]
	dev-python/itemadapter[${PYTHON_USEDEP}]
	dev-python/itemloaders[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/parsel[${PYTHON_USEDEP}]
	dev-python/protego[${PYTHON_USEDEP}]
	>=dev-python/pydispatcher-2.0.5[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/queuelib[${PYTHON_USEDEP}]
	dev-python/service-identity[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/tldextract[${PYTHON_USEDEP}]
	>=dev-python/twisted-17.9.0[${PYTHON_USEDEP}]
	<=dev-python/twisted-22.10.0[${PYTHON_USEDEP}]
	dev-python/w3lib[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	test? (
		dev-python/testfixtures[${PYTHON_USEDEP}]
		dev-python/uvloop[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	py.test -vv --ignore=docs \
		--ignore="tests/test_proxy_connect.py" \
		--ignore="tests/test_utils_display.py" \
		--ignore="tests/test_command_check.py" \
		--ignore="tests/test_feedexport.py" \
		--ignore="tests/test_pipeline_files.py" \
		--ignore="tests/test_pipeline_images.py" \
		--ignore="tests/test_squeues.py" || die
}
