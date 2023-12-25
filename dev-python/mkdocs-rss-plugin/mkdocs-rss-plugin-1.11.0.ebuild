# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="MkDocs plugin to generate a RSS feeds."
HOMEPAGE="https://github.com/Guts/mkdocs-rss-plugin https://pypi.org/project/mkdocs-rss-plugin"
SRC_URI="https://github.com/Guts/mkdocs-rss-plugin/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	dev-python/mkdocs[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]
	test? (
		dev-python/black[${PYTHON_USEDEP}]
		dev-python/feedparser[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-vcs/pre-commit
		dev-python/validator-collection[${PYTHON_USEDEP}]
		dev-python/mkdocs-bootswatch[${PYTHON_USEDEP}]
		dev-python/mkdocs-material[${PYTHON_USEDEP}]
		dev-python/mkdocs-minify-plugin[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/pymdown-extensions[${PYTHON_USEDEP}]
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
	distutils-r1_src_prepare
}

python_test() {
	cd "${S}"
	git init
	git config --global user.name nobody || die
	git config --global user.email foo.bar@example.org || die
	local EPYTEST_IGNORE="${S}/tests/_wip"
	local EPYTEST_DESELECT=(
		tests/test_rss_util.py::TestRssUtil::test_remote_image_ok
		tests/test_integrations_material_social_cards.py::TestRssPluginIntegrationsMaterialSocialCards::test_simple_build
	)
	epytest "${S}"/tests || die "Tests failed with ${EPYTHON}"
}
