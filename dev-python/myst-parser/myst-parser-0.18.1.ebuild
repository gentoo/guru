# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} pypy3 )
DISTUTILS_USE_PEP517=flit
inherit distutils-r1 optfeature

MY_PN="MyST-Parser"
DESCRIPTION="An extended commonmark compliant parser, with bridges to docutils & sphinx"
HOMEPAGE="
	https://pypi.org/project/myst-parser/
	https://github.com/executablebooks/MyST-Parser
"
SRC_URI="https://github.com/executablebooks/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/markdown-it-py[${PYTHON_USEDEP}]
	dev-python/mdit-py-plugins[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/pytest-param-files[${PYTHON_USEDEP}]
		dev-python/pytest-regressions[${PYTHON_USEDEP}]
		<dev-python/sphinx-5.2[${PYTHON_USEDEP}]
		dev-python/sphinx-pytest[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

# TODO: package doc deps
#distutils_enable_sphinx docs \
#	dev-python/sphinx_design \
#	dev-python/sphinxcontrib-mermaid \
#	dev-python/sphinxext-opengraph \
#	dev-python/sphinxext-rediraffe

pkg_postinst() {
	optfeature "linkify plugin support" dev-python/linkify-it-py
}
