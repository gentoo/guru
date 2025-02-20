# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{11..12})
inherit distutils-r1

DESCRIPTION="Terminal-based YouTube player and downloader"
HOMEPAGE="https://github.com/mps-youtube/yewtube https://pypi.org/project/yewtube/"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/mps-youtube/yewtube.git"
	inherit git-r3
else
	SRC_URI="https://github.com/mps-youtube/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
SLOT="0"

IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	media-video/ffmpeg
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pyperclip[${PYTHON_USEDEP}]
	net-misc/yt-dlp[${PYTHON_USEDEP}]
	dev-python/youtube-search-python[${PYTHON_USEDEP}]
	dev-python/pylast[${PYTHON_USEDEP}]
	dev-python/pip[${PYTHON_USEDEP}]
	dev-python/pipenv[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	|| ( media-video/mplayer media-video/mpv )
"

DEPEND="
	test? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	# bug #939186
	sed -i 's/from pip\._vendor //' mps_youtube/__init__.py || die

	distutils-r1_src_prepare
}
