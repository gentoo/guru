# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Robust speech recognition via large-scale weak supervision"
HOMEPAGE="
	https://github.com/openai/whisper
"

SRC_URI="https://github.com/openai/whisper/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/whisper-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sci-ml/pytorch[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/more-itertools[${PYTHON_USEDEP}]
		dev-python/numba[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/regex[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}]
		sci-ml/tiktoken[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="
	test? (
		media-video/ffmpeg
	)
"

# Tests require network connection
RESTRICT="test"
PROPERTIES="test_network"

EPYTEST_DESELECT=(
	tests/test_timing.py::test_dtw_cuda_equivalence
	tests/test_timing.py::test_median_filter_equivalence
	tests/test_transcribe.py::test_transcribe
)

distutils_enable_tests pytest
