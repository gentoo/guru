# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="
	dev-python/ansi2html
	dev-python/markdown
	dev-python/markdown-include
	dev-python/mkdocs-exclude
	dev-python/mkdocs-material
	dev-python/pygments
"

inherit distutils-r1 docs

MYPN="python-${PN}"
MYP="${MYPN}-${PV}"

DESCRIPTION="Dev tools for python"
HOMEPAGE="https://github.com/samuelcolvin/python-devtools"
SRC_URI="https://github.com/samuelcolvin/${MYPN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

S="${WORKDIR}/${MYP}"

distutils_enable_tests pytest

DEPEND="test? (
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"
