# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="5b0e2a202603c1fc00d1fa0c6134c92c15b7e2b7"
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Parallel running of tests, code coverage reports, test profiling, and more"
HOMEPAGE="
	https://github.com/heynemann/pyvows
	https://pypi.org/project/pyVows/
"
SRC_URI="https://github.com/heynemann/${PN}/archive/${COMMIT}.tar.gz -> ${P}-${COMMIT}.tar.gz" # only for 3.0.0
S="${WORKDIR}/${PN,,}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/gevent-1.2.2[${PYTHON_USEDEP}]
	>=dev-python/preggy-1.3.0[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		>=dev-python/colorama-0.3.7[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
