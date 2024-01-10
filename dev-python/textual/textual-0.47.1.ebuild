# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="mkdocs"
DOCS_DIR="docs"
DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature

DESCRIPTION="Modern Text User Interface framework"
HOMEPAGE="https://github.com/Textualize/textual https://pypi.org/project/textual/"
SRC_URI="https://github.com/Textualize/textual/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

RDEPEND="
	>=dev-python/rich-13.3.3[${PYTHON_USEDEP}]
	>=dev-python/markdown-it-py-2.1.0[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		>=dev-python/mkdocs-1.3.0[${PYTHON_USEDEP}]
		<dev-python/mkdocs-2.0.0[${PYTHON_USEDEP}]
		dev-python/mkdocstrings[${PYTHON_USEDEP}]
		dev-python/mkdocstrings-python[${PYTHON_USEDEP}]
		>=dev-python/mkdocs-material-9.0.11[${PYTHON_USEDEP}]
		<dev-python/mkdocs-material-10.0.0[${PYTHON_USEDEP}]
		>=dev-python/time-machine-2.6.0[${PYTHON_USEDEP}]
		<dev-python/time-machine-3.0.0[${PYTHON_USEDEP}]
		dev-python/httpx[${PYTHON_USEDEP}]
		>=dev-python/textual-dev-1.2.0[${PYTHON_USEDEP}]
		<dev-python/textual-dev-2.0.0[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/griffe[${PYTHON_USEDEP}]
	)
"

DEPEND="${RDEPEND}"

distutils_enable_tests pytest
EPYTEST_DESELECT=(
	# Those tests ask to press keys
	tests/snapshot_tests/test_snapshots.py

	# Need a package that should be optional
	tests/text_area/test_languages.py::test_register_language
	tests/text_area/test_languages.py::test_register_language_existing_language
)

pkg_postinst() {
	optfeature "bindings for python" dev-python/tree-sitter
	optfeature "support for [language]" dev-libs/tree-sitter-[language]
}
