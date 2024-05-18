# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 git-r3

DESCRIPTION="Plugin for MkDocs to keep a simple blog section inside your documentation."
HOMEPAGE="https://github.com/fmaida/mkdocs-blog-plugin https://pypi.org/project/mkdocs-blog-plugin"
EGIT_REPO_URI="https://github.com/fmaida/mkdocs-blog-plugin.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/mkdocs[${PYTHON_USEDEP}]
"
DEPEND="${BDEPEND}"
