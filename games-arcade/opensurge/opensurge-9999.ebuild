# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

MY_PV="${PV/_/-}"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alemart/opensurge"
else
	SRC_URI="https://github.com/alemart/opensurge/archive/v${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${MY_PV}/"
fi

DESCRIPTION="fun 2D retro platformer inspired by old-school Sonic games"
HOMEPAGE="http://opensurge2d.org/"
LICENSE="GPL-3"
SLOT="0"

# Allegro:5 libs to USE
# - image: jpeg,png
# - primitives: opengl
# - font+ttf: truetype
# - acodec+audio: alsa/openal/oss/pulseaudio (present in REQUIRED_USE)
# - dialog: gtk
DEPEND="
	>=media-libs/allegro-5.2.5:=
	media-libs/allegro[jpeg,png,opengl,truetype,gtk]
	dev-games/surgescript:=
"
RDEPEND="${DEPEND}"
