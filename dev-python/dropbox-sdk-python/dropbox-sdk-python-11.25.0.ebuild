# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="The offical Dropbox SDK for Python"
HOMEPAGE="https://www.dropbox.com/developers"
SRC_URI="https://github.com/dropbox/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=dev-python/requests-2.16.2[${PYTHON_USEDEP}]
	>=dev-python/six-1.12.0[${PYTHON_USEDEP}]
	>=dev-python/stone-2.0.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND=""

distutils_enable_tests pytest

# does not find module mock
RESTRICT="test"

python_prepare_all() {
	# Don't run tests via setup.py pytest
	sed -i "s/'pytest-runner == 5.2.0',//" setup.py || die

	distutils-r1_python_prepare_all
}
