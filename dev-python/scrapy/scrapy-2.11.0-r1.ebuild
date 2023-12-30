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
IUSE="test"
RESTRICT="!test? ( test )"

# The 'PyDispatcher>=2.0.5' distribution was not found and is required by Scrapy
# https://bugs.gentoo.org/684734
RDEPEND="dev-python/cssselect[${PYTHON_USEDEP}]
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
	>=dev-python/twisted-18.9.0[${PYTHON_USEDEP}]
	dev-python/w3lib[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		${RDEPEND}
		dev-python/testfixtures[${PYTHON_USEDEP}]
		dev-python/uvloop[${PYTHON_USEDEP}]
	)
"

PATCHES="${FILESDIR}"/${P}-lift-twisted-restriction.patch

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# these require (local) network access
	tests/test_command_check.py
	tests/test_feedexport.py
	tests/test_pipeline_files.py::TestFTPFileStore::test_persist
	# Flaky test: https://github.com/scrapy/scrapy/issues/6193
	tests/test_crawl.py::CrawlTestCase::test_start_requests_laziness
	)
EPYTEST_IGNORE=( docs )
