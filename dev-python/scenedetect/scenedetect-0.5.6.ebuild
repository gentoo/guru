# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Video Scene Cut Detection and Analysis Tool"
HOMEPAGE="https://github.com/Breakthrough/PySceneDetect"
SRC_URI="https://github.com/Breakthrough/PySceneDetect/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # Requires video file not provided

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	media-libs/opencv[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/PySceneDetect-${PV}

distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	sed -i -e '/setup_requires/d' -e '/extras_require/d' setup.py || die
	sed -i 's/description-file/description_file/' setup.cfg || die # bug #800581
}
