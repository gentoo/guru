# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

COMMIT="d4e06881367fdcd21572ae9f2d3280ffb5815f26"
MY_P="${PN}-${COMMIT}"

DESCRIPTION="Automatically invoke the xrandr to set the parameters for the display output"
HOMEPAGE="https://gitlab.com/lvml/mpv-plugin-xrandr"

SRC_URI="https://gitlab.com/lvml/${PN}/-/archive/${COMMIT}/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64"

RDEPEND="
	x11-apps/xrandr
"

S="${WORKDIR}/${MY_P}"

MPV_PLUGIN_FILES=( xrandr.lua )
