# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 optfeature

DESCRIPTION="Manipulate audio with an simple and easy high level interface"
HOMEPAGE="http://pydub.com/"
SRC_URI="https://github.com/jiaaro/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest

BDEPEND="
	test? (
		media-video/ffmpeg
	)
	"

python_test() {
	eunittest test/
}

pkg_postinst() {
	optfeature "opening and saving non-wav files - like mp3" media-video/ffmpeg
	#optfeature "playing audio" dev-python/simpleaudio # upstream suggests this, not available in gentoo or guru
	optfeature "playing audio" dev-python/pyaudio
}
