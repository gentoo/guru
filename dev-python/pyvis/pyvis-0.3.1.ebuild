EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python package for creating and visualizing interactive network graphs"
HOMEPAGE="
	https://github.com/WestHealth/pyvis
	https://pypi.org/project/pyvis/
	https://pyvis.readthedocs.io/
"
SRC_URI="https://github.com/WestHealth/pyvis/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-python/jinja2-2.10[${PYTHON_USEDEP}]
	>=dev-python/networkx-1.11[${PYTHON_USEDEP}]
	>=dev-python/ipython-5.3.0[${PYTHON_USEDEP}]
	>=dev-python/pandas-0.23.4[${PYTHON_USEDEP}]
	>=dev-python/jsonpickle-1.4.1[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.19.5[${PYTHON_USEDEP}]
"
