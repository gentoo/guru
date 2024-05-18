# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{10..12} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="dev-python/mkdocs-bootstrap-tables-plugin"
DOCS_INITIALIZE_GIT=1

inherit distutils-r1 docs

DESCRIPTION="A mkdocs plugin for displaying the last commit and a list of contributors."
HOMEPAGE="https://github.com/byrnereese/mkdocs-git-committers-plugin"
SRC_URI="https://github.com/byrnereese/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/PyGithub[${PYTHON_USEDEP}]
	>=dev-python/mkdocs-1.0[${PYTHON_USEDEP}]
"
