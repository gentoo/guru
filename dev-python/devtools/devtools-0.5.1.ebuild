# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

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
distutils_enable_sphinx docs dev-python/sphinxcontrib-websupport

DEPEND="test? (
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pytest-isort[${PYTHON_USEDEP}]
	dev-python/pytest-mock[${PYTHON_USEDEP}]
)"
