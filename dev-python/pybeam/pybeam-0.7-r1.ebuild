# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCS_BUILDER="sphinx"
DOCS_DIR="doc"
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 docs

DESCRIPTION="Python module to parse Erlang BEAM files"
HOMEPAGE="https://github.com/matwey/pybeam"
SRC_URI="https://github.com/matwey/pybeam/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/construct[${PYTHON_USEDEP}]"
DEPEND="test? ( dev-python/six[${PYTHON_USEDEP}] )"

distutils_enable_tests unittest
