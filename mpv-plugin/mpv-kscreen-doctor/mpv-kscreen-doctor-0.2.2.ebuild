# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

DESCRIPTION="Set the display refresh rate that best approximates the content fps"
HOMEPAGE="https://gitlab.com/smaniottonicola/mpv-kscreen-doctor"
SRC_URI="https://gitlab.com/smaniottonicola/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	kde-plasma/libkscreen
"
RDEPEND="${DEPEND}"

MPV_PLUGIN_FILES=( ${PN}.lua )
