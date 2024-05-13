# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

HASH="d1d846abd7d25e4e83a78d22ee067a22"
COMMIT="b23b20e830bba024836f8b09412000658edee95c"
MY_P="${PN}-${COMMIT}"

DESCRIPTION="Use KDialog to add files to playlist, subtitles to playing video or open URLs"
HOMEPAGE="https://gist.github.com/ntasos/d1d846abd7d25e4e83a78d22ee067a22"
SRC_URI="https://gist.github.com/ntasos/${HASH}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${HASH}-${COMMIT}"

LICENSE="Unlicense"
KEYWORDS="~amd64"

RDEPEND="
	kde-apps/kdialog
	x11-misc/xdotool
"

MPV_PLUGIN_FILES=( ${PN}.lua )
