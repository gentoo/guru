# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

MY_PV="r${PV//./_}"

DESCRIPTION="Automatically invoke the xrandr to set the parameters for the display output"
HOMEPAGE="https://gitlab.com/lvml/mpv-plugin-xrandr"
SRC_URI="https://gitlab.com/lvml/mpv-plugin-xrandr/-/archive/tags/${MY_PV}/mpv-plugin-xrandr-tags-${MY_PV}.tar.bz2 -> ${P}.tar.bz2"

S="${WORKDIR}/${PN}-tags-${MY_PV}"

LICENSE="GPL-2"
KEYWORDS="~amd64"

RDEPEND="
	x11-apps/xrandr
"

MPV_PLUGIN_FILES=( xrandr.lua )
