# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Easily serialize Data Classes to and from JSON"
HOMEPAGE="https://github.com/lidatong/dataclasses-json"
SRC_URI="https://github.com/lidatong/dataclasses-json/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P/_/-}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/marshmallow-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/marshmallow_enum-1.5.1[${PYTHON_USEDEP}]
	>=dev-python/typing_inspect-0.4.0[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
		>=dev-python/mypy-0.710[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
