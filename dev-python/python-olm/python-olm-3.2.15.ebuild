# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Python bindings for dev-libs/olm"
HOMEPAGE="https://gitlab.matrix.org/matrix-org/olm/"
SRC_URI="https://gitlab.matrix.org/matrix-org/olm/-/archive/${PV}/olm-${PV}.tar.bz2"
S="${WORKDIR}/olm-${PV}/python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/olm"
RDEPEND="
	${DEPEND}
	dev-python/future[${PYTHON_USEDEP}]
	virtual/python-cffi[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/aspectlib[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
	)
"

DOCS=( README-python.md )

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/alabaster

src_prepare() {
	distutils-r1_src_prepare

	# To avoid merge collision with dev-libs/olm
	mv "README.md" "README-python.md" || die
}
