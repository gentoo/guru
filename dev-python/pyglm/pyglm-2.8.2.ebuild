# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

HASH="58e0db58cc860c0c6f7f6ee3a462e17a431646a4"
DESCRIPTION="Fast OpenGL Mathematics (GLM) for Python"
HOMEPAGE="https://github.com/Zuzu-Typ/PyGLM https://pypi.org/project/PyGLM"
SRC_URI="
	https://github.com/Zuzu-Typ/PyGLM/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/Zuzu-Typ/glm/archive/${HASH}.tar.gz -> ${P}-glm.gh.tar.gz
"
S="${WORKDIR}/PyGLM-${PV}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"
DOCS+=( wiki )

RDEPEND="
	media-libs/glm
	test? ( dev-python/numpy[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

src_prepare() {
	default
	mv "${WORKDIR}/glm-${HASH}"/* "${S}/PyGLM_lib/glm" || die "Could not move the glm source"
}

python_test() {
	rm -rf "${S}/pyglm" "${S}/glm" || die "Could not remove the source directory"
	epytest
}
