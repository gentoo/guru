# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit cmake-utils git-r3 distutils-r1

DESCRIPTION="Audio synchronization feature for vidify "
HOMEPAGE="https://github.com/vidify/audiosync"
EGIT_REPO_URI="https://github.com/vidify/audiosync.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=

IUSE="debug"

RDEPEND="
	media-video/ffmpeg[openssl]
	media-video/vidify[${PYTHON_USEDEP}]
	sci-libs/fftw
	debug? ( sci-visualization/gnuplot )"

src_prepare() {
	use debug && eapply "${FILESDIR}/${P}-debug.patch"
	default
}
