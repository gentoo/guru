# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Easily serialize Data Classes to and from JSON"
HOMEPAGE="
	https://github.com/lidatong/dataclasses-json/
	https://pypi.org/project/dataclasses-json/
"

SRC_URI="https://github.com/lidatong/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="!test? ( test )"

RDEPEND="
	${PYTHON_DEPS}
	<dev-python/marshmallow-4.0.0[${PYTHON_USEDEP}]
	dev-python/typing-inspect[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

BDEPEND="
	${DISTUTILS_DEPS}
	${PYTHON_DEPS}
	test? (
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/mypy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare(){
	default
	sed -i \
		-e 's:0.0.0:'${PV}':' \
		-e 's:, ["]poetry-dynamic-versioning["]::' \
		-e 's:poetry_dynamic_versioning.backend:poetry.core.masonry.api:' \
		pyproject.toml || die
}
