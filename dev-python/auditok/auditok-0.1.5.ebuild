# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 optfeature

DESCRIPTION="A module for Audio/Acoustic Activity Detection"
HOMEPAGE="https://github.com/amsehili/auditok/"
SRC_URI="https://github.com/amsehili/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	test? (
		dev-python/pydub[${PYTHON_USEDEP}]
		dev-python/genty[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
	"

distutils_enable_tests unittest

python_test() {
	eunittest tests/
}

pkg_postinst() {
	optfeature "reading audio files in popular audio formats (ogg, mp3, etc.) or extracting audio from a video file" dev-python/pydub
	optfeature "reading audio data from the microphone and playing audio back" dev-python/pyaudio
	optfeature "plotting audio signal and detections" dev-python/matplotlib
	optfeature "matplotlib. Also used for some math operations instead of standard python if available" dev-python/numpy
}
