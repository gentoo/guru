# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1

DESCRIPTION="Target File Size Video Compression for Discord with FFmpeg"
HOMEPAGE="https://github.com/zfleeman/ffmpeg4discord"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/zfleeman/ffmpeg4discord.git"
else
	SRC_URI="https://github.com/zfleeman/ffmpeg4discord/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT=0

BDEPEND="
	>=dev-python/setuptools-69[${PYTHON_USEDEP}]
"
RDEPEND="
	>=dev-python/flask-3.0.1[${PYTHON_USEDEP}]
	>=dev-python/ffmpeg-python-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.5.0[${PYTHON_USEDEP}]
"

distutils_enable_tests unittest
