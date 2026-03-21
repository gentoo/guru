# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Hardware-aware local AI assistant with RAG for codebases"
HOMEPAGE="https://github.com/mreinrt/Tangi"
SRC_URI="https://github.com/mreinrt/Tangi/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
    dev-python/pyqt6[${PYTHON_USEDEP}]
    dev-python/llama-cpp-python[${PYTHON_USEDEP}]
    dev-python/chromadb[${PYTHON_USEDEP}]
    dev-python/transformers[${PYTHON_USEDEP}]
    dev-python/torch[${PYTHON_USEDEP}]
    dev-python/sentence-transformers[${PYTHON_USEDEP}]
    dev-python/huggingface_hub[${PYTHON_USEDEP}]
    dev-python/psutil[${PYTHON_USEDEP}]
    dev-python/markdown[${PYTHON_USEDEP}]
    sci-libs/openblas
"

DEPEND="${RDEPEND}"

src_install() {
    distutils-r1_src_install
}
