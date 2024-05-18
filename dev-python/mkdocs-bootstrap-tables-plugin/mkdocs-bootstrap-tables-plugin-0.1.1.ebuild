# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="A MkDocs plugin to add bootstrap classes to plan markdown generated tables."
HOMEPAGE="https://github.com/byrnereese/mkdocs-bootstrap-tables-plugin"
SRC_URI="https://github.com/byrnereese/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-python/mkdocs-1.0[${PYTHON_USEDEP}]"
