# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="Audio synchronization feature for vidify "
HOMEPAGE="https://github.com/vidify/audiosync https://vidify.org"
SRC_URI="https://github.com/vidify/audiosync/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug"

RDEPEND="
	media-sound/pulseaudio
	media-video/ffmpeg[openssl]
	media-video/vidify[${PYTHON_USEDEP}]
	sci-libs/fftw
	debug? ( sci-visualization/gnuplot )"

S="${WORKDIR}/audiosync-${PV}"

src_prepare() {
	use debug && sed -i -e "/defines.append(('DEBUG', '1'))/s/^# *//" setup.py
	default
}

src_test() {
	mkdir test_build
	cd test_build
	cmake .. -DBUILD_TESTING=YES
	emake
	emake test
	cd ..
}
