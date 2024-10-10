# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="
	dev-python/termynal
	dev-python/mkdocstrings
	dev-python/mkdocstrings-python
	dev-python/mkdocs-material
	dev-python/mkdocs-minify-plugin
	dev-python/mkdocs-git-committers-plugin
	dev-python/mkdocs-git-revision-date-localized-plugin
"
DOCS_INITIALIZE_GIT=1

inherit distutils-r1 docs

DESCRIPTION="MkDocs plugin to generate a RSS feeds."
HOMEPAGE="https://github.com/Guts/mkdocs-rss-plugin https://pypi.org/project/mkdocs-rss-plugin"
SRC_URI="
	https://github.com/Guts/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/henri-gasc/${PN}-cache/archive/refs/tags/${PV}.tar.gz -> ${PN}-cache-${PV}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# RESTRICT="doc? ( network-sandbox )"

BDEPEND="
	>=dev-python/GitPython-3.1[${PYTHON_USEDEP}]
	<dev-python/GitPython-3.2[${PYTHON_USEDEP}]
	>=dev-python/mkdocs-1.5[${PYTHON_USEDEP}]
	<dev-python/mkdocs-2[${PYTHON_USEDEP}]
	>=dev-python/cachecontrol-0.14[${PYTHON_USEDEP}]
	<dev-python/cachecontrol-1[${PYTHON_USEDEP}]
	dev-python/filelock[${PYTHON_USEDEP}]
	>=dev-python/requests-2.31[${PYTHON_USEDEP}]
	<dev-python/requests-3[${PYTHON_USEDEP}]
	test? (
		>=dev-python/feedparser-6.0.11[${PYTHON_USEDEP}]
		<dev-python/feedparser-6.1[${PYTHON_USEDEP}]
		>=dev-python/jsonfeed-1.1.2[${PYTHON_USEDEP}]
		<dev-python/jsonfeed-2[${PYTHON_USEDEP}]
		>=dev-python/mkdocs-material-9[${PYTHON_USEDEP},social]
		>=dev-python/validator-collection-1.5[${PYTHON_USEDEP}]
		<dev-python/validator-collection-1.6[${PYTHON_USEDEP}]
	)
"
DEPEND="${BDEPEND}"

distutils_enable_tests pytest

src_prepare() {
	sed -i \
		-e 's/--cov-config=setup.cfg//' \
		-e 's/--cov=mkdocs_rss_plugin//' \
		-e 's/--cov-report=html//' \
		-e 's/--cov-report=term//' \
		-e 's/--cov-report=xml//' \
		"${S}/setup.cfg" || die
	cp "${WORKDIR}/${PN}-cache-${PV}/.cache" -rt "${S}" || die
	distutils-r1_src_prepare
}

python_test() {
	mkdir "${S}/.git"
	local EPYTEST_IGNORE="${S}/tests/_wip"
	local EPYTEST_DESELECT=(
		# Most tests need internet access
		tests/test_build.py::TestBuildRss
		tests/test_rss_util.py::TestRssUtil::test_remote_image_ok
		tests/test_integrations_material_social_cards.py::TestRssPluginIntegrationsMaterialSocialCards::test_simple_build
	)
	epytest "${S}"/tests || die "Tests failed with ${EPYTHON}"
}
