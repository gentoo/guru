# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Python bindings for dev-libs/olm"
HOMEPAGE="https://gitlab.matrix.org/matrix-org/olm/"
SRC_URI="https://gitlab.matrix.org/matrix-org/olm/-/archive/${PV}/${P}.tar.bz2"
S="${WORKDIR}/${P}/python"
RESTRICT="!test? ( test )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/olm
	dev-python/cffi[${PYTHON_USEDEP}]
	test? (
		dev-python/aspectlib[${PYTHON_USEDEP}]
		dev-python/future[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/pytest-flake8[${PYTHON_USEDEP}]
		dev-python/pytest-isort[${PYTHON_USEDEP}]
	)
"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	# To avoid merge collision with dev-libs/olm
	rm "${ED}/usr/share/doc/${P}/README.md" || die
}
