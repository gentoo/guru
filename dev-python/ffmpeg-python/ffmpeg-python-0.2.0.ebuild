# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Python bindings for FFmpeg - with complex filtering support"
HOMEPAGE="https://github.com/kkroening/ffmpeg-python"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-video/ffmpeg
"
RDEPEND="
	${DEPEND}
"

python_prepare_all() {
	sed -e '/\<pytest-runner\>/d' -i setup.py
	distutils-r1_python_prepare_all
}
