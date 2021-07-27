# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Python interface to the Google WebRTC Voice Activity Detector (VAD)"
HOMEPAGE="https://github.com/wiseman/py-webrtcvad"
SRC_URI="https://github.com/wiseman/py-${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/py-${P}"

distutils_enable_tests nose

DEPEND="
	test? (
		dev-python/memory_profiler[${PYTHON_USEDEP}]
	)
	"
