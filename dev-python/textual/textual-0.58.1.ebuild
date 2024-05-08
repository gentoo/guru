# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="
	dev-python/mkdocstrings
	dev-python/mkdocstrings-python
	dev-python/mkdocs-material
	dev-python/mkdocs-exclude
	dev-python/mkdocs-rss-plugin
	dev-python/pytz
"
DOCS_INITIALIZE_GIT=1

inherit distutils-r1 docs optfeature

DESCRIPTION="Modern Text User Interface framework"
HOMEPAGE="https://github.com/Textualize/textual https://pypi.org/project/textual/"
SRC_URI="https://github.com/Textualize/textual/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/markdown-it-py-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.3.3[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/httpx[${PYTHON_USEDEP}]
		>=dev-python/textual-dev-1.2.0[${PYTHON_USEDEP}]
		<dev-python/textual-dev-2.0.0[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/griffe[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/fix-mkdocstrings.patch"
)

EPYTEST_DESELECT=(
	# Those tests ask to press keys
	tests/snapshot_tests/test_snapshots.py
	# Need a package that should be optional
	tests/text_area/test_languages.py
)
distutils_enable_tests pytest

python_compile_all() {
	echo "INHERIT: mkdocs-offline.yml" > "${S}/mkdocs.yml"
	grep -v "\- \"*[Bb]log" "${S}/mkdocs-nav.yml" >> "${S}/mkdocs.yml"
	docs_compile
	rm "${S}/mkdocs.yml"
}

pkg_postinst() {
	optfeature "bindings for python" dev-python/tree-sitter
	optfeature "support for [language]" dev-libs/tree-sitter-[language]
}
