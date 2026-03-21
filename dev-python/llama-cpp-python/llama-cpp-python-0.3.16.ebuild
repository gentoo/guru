# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
DISTUTILS_USE_PEP517=scikit-build-core
DISTUTILS_EXT=1

inherit distutils-r1 git-r3

DESCRIPTION="Python bindings for llama.cpp with OpenBLAS support"
HOMEPAGE="https://github.com/abetlen/llama-cpp-python"
EGIT_REPO_URI="https://github.com/abetlen/llama-cpp-python.git"
EGIT_COMMIT="v${PV}"
EGIT_SUBMODULES=("*")

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    sci-libs/openblas
    dev-python/numpy[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="
    dev-python/cython[${PYTHON_USEDEP}]
    dev-python/setuptools[${PYTHON_USEDEP}]
    dev-python/wheel[${PYTHON_USEDEP}]
    dev-python/scikit-build-core[${PYTHON_USEDEP}]
"

src_configure() {
    export CMAKE_ARGS="-DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS"
    export LDFLAGS="-lopenblas ${LDFLAGS}"
    export CPPFLAGS="-I/usr/include/openblas ${CPPFLAGS}"
    distutils-r1_src_configure
}

python_configure() {
    distutils-r1_python_configure
}
