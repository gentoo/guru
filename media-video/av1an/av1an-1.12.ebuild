# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Cross-platform framework to streamline encoding"
HOMEPAGE="https://github.com/master-of-zen/Av1an"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/master-of-zen/Av1an.git"
else
	SRC_URI="https://github.com/master-of-zen/Av1an/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${P^}
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/scenedetect[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	media-libs/libaom[examples]
	media-libs/opencv[python,${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

src_prepare() {
	distutils-r1_src_prepare
	sed -e '/opencv-python/d'\
		-e '/scenedetect/d' \
		-i setup.py || die
}
