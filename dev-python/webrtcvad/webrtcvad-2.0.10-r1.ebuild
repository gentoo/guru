# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Python interface to the Google WebRTC Voice Activity Detector (VAD)"
HOMEPAGE="https://github.com/wiseman/py-webrtcvad"
SRC_URI="https://github.com/wiseman/py-${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://gentoo.kropotkin.rocks/distfiles/${P}-patches.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# Depends on a package removed from ::gento (bug #915162)
RESTRICT="test"

S="${WORKDIR}/py-${P}"

PATCHES=( "${WORKDIR}/${PN}-update-webrtc.patch" "${WORKDIR}/${PN}-fix-mem-leak.patch" "${WORKDIR}/${PN}-fix-oob.patch" )

