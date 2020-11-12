# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=" Use any offline or online media file or stream as a PulseAudio source"

HOMEPAGE="https://github.com/MatthiasCoppens/pulseaudio-virtualmic"

if [ "${PV}" == 9999 ]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MatthiasCoppens/pulseaudio-virtualmic.git"
else
	SRC_URI="https://github.com/MatthiasCoppens/pulseaudio-virtualmic/archive/v${PV}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

RESTRICT="mirror test"

RDEPEND="media-video/ffmpeg
	media-sound/pulseaudio"
DEPEND="${RDEPEND}"

src_install() {
	exeinto /usr/bin
	doexe virtualmic
}
