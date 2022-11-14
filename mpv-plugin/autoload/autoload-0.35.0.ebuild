# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

DESCRIPTION="Loads playlist entries before and after the the currently played file"
HOMEPAGE="https://github.com/mpv-player/mpv/tree/master/TOOLS/lua"

# use the already available mpv tarball
SRC_URI="https://github.com/mpv-player/mpv/archive/v${PV}.tar.gz -> mpv-${PV}.tar.gz"

# since this comes from mpv, use its licenses
LICENSE="LGPL-2.1+ GPL-2+ BSD ISC MIT"
KEYWORDS="~amd64"

# lock mpv version
RDEPEND="~media-video/mpv-${PV}"

S="${WORKDIR}/mpv-${PV}/TOOLS/lua"

MPV_PLUGIN_FILES=( ${PN}.lua )
