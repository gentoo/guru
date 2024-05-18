# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

MY_PN="mpv-scripts"

DESCRIPTION="Gives mpv the capability to copy and paste while being smart and customizable"
HOMEPAGE="https://github.com/Eisa01/mpv-scripts"
SRC_URI="https://github.com/Eisa01/${MY_PN}/archive/refs/tags/2.2.1.tar.gz -> Eisa01-${MY_PN}-2.2.1.tar.gz"

S="${WORKDIR}/${MY_PN}-2.2.1/scripts"

LICENSE="BSD-2"
KEYWORDS="~amd64"

RDEPEND="
	|| (
		gui-apps/wl-clipboard
		x11-misc/xclip
	)
"

MPV_PLUGIN_FILES=( ${PN}.lua )
