# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

SRC_URI="https://github.com/Tinche/cattrs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
DESCRIPTION="Complex custom class converters for attrs"
HOMEPAGE="https://github.com/Tinche/cattrs"
LICENSE="MIT"
SLOT="0"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '>=dev-python/attrs-20[${PYTHON_USEDEP}]')
"
DEPEND="
	${RDEPEND}
	test? (
		$(python_gen_cond_dep '
			dev-python/bson[${PYTHON_USEDEP}]
			dev-python/immutables[${PYTHON_USEDEP}]
			dev-python/hypothesis[${PYTHON_USEDEP}]
			dev-python/msgpack[${PYTHON_USEDEP}]
			dev-python/pendulum[${PYTHON_USEDEP}]
			dev-python/pytest-benchmark[${PYTHON_USEDEP}]
			dev-python/pyyaml[${PYTHON_USEDEP}]
			dev-python/tomlkit[${PYTHON_USEDEP}]
			dev-python/ujson[${PYTHON_USEDEP}]
		')
		dev-python/orjson[${PYTHON_SINGLE_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs
