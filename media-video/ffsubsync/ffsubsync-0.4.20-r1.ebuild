# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Automagically syncronize subtitles with video"
HOMEPAGE="https://github.com/smacke/ffsubsync"
SRC_URI="https://github.com/smacke/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	~dev-python/auditok-0.1.5[${PYTHON_USEDEP}]
	dev-python/cchardet[${PYTHON_USEDEP}]
	dev-python/ffmpeg-python[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.12.0[${PYTHON_USEDEP}]
	>=dev-python/pysubs2-1.2.0[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	>=dev-python/srt-3.0.0[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/webrtcvad[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_prepare_all() {
	sed "/argparse/d" -i requirements.txt || die
	distutils-r1_python_prepare_all
}
