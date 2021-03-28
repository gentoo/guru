# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="A ncurses mixer for PulseAudio inspired by pavucontrol"
HOMEPAGE="https://github.com/fulhax/ncpamixer"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/fulhax/ncpamixer.git"
	inherit git-r3
else
	SRC_URI="https://github.com/fulhax/ncpamixer/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+wide"

DEPEND="
	media-sound/pulseaudio
	sys-libs/ncurses
"
RDEPEND="${DEPEND}"

CMAKE_USE_DIR="${S}/src"

src_configure() {
	local mycmakeargs=(
		-DUSE_WIDE="$(usex wide)"
	)

	cmake_src_configure
}
