# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit desktop distutils-r1 xdg

DESCRIPTION="A cross platform front-end GUI of the popular youtube-dl written in wxPython."
HOMEPAGE="https://yt-dlg.github.io/yt-dlg/"
# Using latest commit from Mars 19, 2024 as of August 5, 2024.
# Latest releases and tags are from 2021 and are probably deprecated and incompatible with current Python versions.
# Same applies for the dependencies of yt-dlp.
SHA="264699bb425efd988523ebb8bbfb8f67d009f884"
SRC_URI="https://github.com/yt-dlg/yt-dlg/archive/${SHA}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${SHA}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"

IUSE="ffmpeg"

DEPEND="${PYTHON_DEPS}
	>=dev-python/wxpython-4.2.0:*[${PYTHON_USEDEP}]
	net-misc/yt-dlp[${PYTHON_USEDEP}]
	>=dev-python/PyPubSub-4.0.3
	ffmpeg? ( media-video/ffmpeg )
"
RDEPEND="${DEPEND}"

# I don't know how to enable the test phase.
distutils_enable_tests pytest

DOCS=( README.md )

python_test() {
	local tests=( ditem dlist parsers utils widgets )
	local current_test
	for current_test in tests; do
		"${EPYTHON}" "tests/test_${curent_test}.py" || die "Tests fail with ${EPYTHON}"
	done
}

src_install() {
	distutils-r1_src_install
	domenu yt-dlg.desktop
}
