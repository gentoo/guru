# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

MYPV="${PV/_beta/b}"

DESCRIPTION="Extension pack for Python Markdown"
HOMEPAGE="
	https://github.com/facelessuser/mkdocs-material-extensions
	https://pypi.org/project/mkdocs-material-extensions
"
SRC_URI="https://github.com/facelessuser/${PN}/archive/${MYPV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# mkdocs-material depends on this package creating a circular dep
PDEPEND=">=dev-python/mkdocs-material-5.0.0[${PYTHON_USEDEP}]"

# we still need mkdocs-material for test, but the circular dep can be avoided
# by first emerging with FEATURES="-test"
DEPEND="test? ( ${PDEPEND} )"

S="${WORKDIR}/${PN}-${MYPV}"

distutils_enable_tests pytest
