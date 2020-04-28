# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Pytest plugin to randomly order tests and control random.seed"
HOMEPAGE="
	https://pypi.python.org/pypi/pytest-randomly
	https://github.com/pytest-dev/pytest-randomly
"
SRC_URI="https://github.com/pytest-dev/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/factory_boy[${PYTHON_USEDEP}]
	dev-python/faker[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]

	$(python_gen_cond_dep 'dev-python/importlib_metadata[${PYTHON_USEDEP}]' python3_6 python3_7)
"
#not really needed
#	dev-python/isort[${PYTHON_USEDEP}]
#	$(python_gen_cond_dep 'dev-python/black[${PYTHON_USEDEP}]' python3_8)
#	dev-python/secretstorage[${PYTHON_USEDEP}]
#	dev-python/twine[${PYTHON_USEDEP}]

DEPEND="
	test? (
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)
"
#not really needed
#		$(python_gen_cond_dep 'dev-python/check-manifest[${PYTHON_USEDEP}]' python3_8)
#		dev-python/multilint[${PYTHON_USEDEP}]

distutils_enable_tests pytest
