# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Modern Text User Interface framework"
HOMEPAGE="https://github.com/Textualize/textual https://pypi.org/project/textual"
SRC_URI="https://github.com/Textualize/textual/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
# KEYWORDS="~amd64" # If set, can not commit because of dev-python/py-nanoid and dev-python/mkdocs-blog-plugin
IUSE="doc"

RDEPEND="
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/importlib_metadata[${PYTHON_USEDEP}]
	test? (
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/pytest-aiohttp[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/pytest-syrupy[${PYTHON_USEDEP}]
		dev-python/py-nanoid[${PYTHON_USEDEP}]
		dev-python/click[${PYTHON_USEDEP}]
		dev-python/time-machine[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	)
	doc? (
		dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/mkdocs[${PYTHON_USEDEP}]
		dev-python/mkdocs-exclude[${PYTHON_USEDEP}]
		dev-python/mkdocs-mkdocstrings[${PYTHON_USEDEP}]
		dev-python/mkdocs-mkdocstrings-python[${PYTHON_USEDEP}]
		dev-python/mkdocs-material[${PYTHON_USEDEP}]
		dev-python/mkdocs-material-extensions[${PYTHON_USEDEP}]
		dev-python/mkdocs-blog-plugin[${PYTHON_USEDEP}]
		dev-python/mkdocs-rss-plugin[${PYTHON_USEDEP}]
		dev-python/mkdocs-autorefs[${PYTHON_USEDEP}]
		dev-python/py-nanoid[${PYTHON_USEDEP}]
	)
"
DEPEND="
	${BDEPEND}
	${RDEPEND}
"

distutils_enable_tests pytest

python_prepare_all() {
	# MkDocs need git repo
	if use doc; then
		git init -b temp || die
		git config user.email "you@example.com" || die
		git config user.name "Your Name" || die
		git add . || die
		git commit -m 'init' -q || die
	fi
	distutils-r1_python_prepare_all
}

python_install() {
	if use doc; then
		mkdocs build --config-file mkdocs-common.yml
		einstalldocs site
	fi
	distutils-r1_python_install
}

python_test() {
	# Those tests ask to press keys
	local EPYTEST_IGNORE="tests/snapshot_tests/test_snapshots.py"
	epytest "${S}/tests" || die "Tests failed with ${EPYTHON}"
}
