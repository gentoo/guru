# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="MkDocs plugin to generate a RSS feeds."
HOMEPAGE="https://github.com/Guts/mkdocs-rss-plugin https://pypi.org/project/mkdocs-rss-plugin"
SRC_URI="https://github.com/Guts/mkdocs-rss-plugin/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND=""
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/mkdocs[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]
	doc? (
		dev-python/mkdocs-bootswatch[${PYTHON_USEDEP}]
		dev-python/mkdocs-minify-plugin[${PYTHON_USEDEP}]
		dev-python/pygments[${PYTHON_USEDEP}]
		dev-python/pymdown-extensions[${PYTHON_USEDEP}]
	)
"
DEPEND="${BDEPEND}"

# No test because of upstream bug
# BDEPEND+="
# 	test? (
# 		dev-python/black[${PYTHON_USEDEP}]
# 		dev-python/feedparser[${PYTHON_USEDEP}]
# 		dev-python/flake8[${PYTHON_USEDEP}]
# 		dev-vcs/pre-commit
# 		dev-python/pytest-cov[${PYTHON_USEDEP}]
# 	)"
# distutils_enable_tests pytest
