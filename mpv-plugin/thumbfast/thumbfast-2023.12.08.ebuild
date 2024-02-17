# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_MPV="rdepend"
MPV_REQ_USE="lua"
inherit mpv-plugin

COMMIT="03e93feee5a85bf7c65db953ada41b4826e9f905"
DESCRIPTION="High-performance on-the-fly thumbnailer script for mpv."
HOMEPAGE="https://github.com/po5/thumbfast"
SRC_URI="https://github.com/po5/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MPL-2"
KEYWORDS="~amd64"

RDEPEND="app-shells/bash"

MPV_PLUGIN_FILES=(
	thumbfast.lua
)

DOCS=(
	thumbfast.conf
	README.md
)

pkg_postinst() {
	mpv-plugin_pkg_postinst
	einfo "thumbfast requires using a supported ui (such as mpv-plugin/mfpbar)."
	# TODO(NRK): add a useflag for the vanilla-osc fork??
	# https://github.com/po5/thumbfast/blob/vanilla-osc/player/lua/osc.lua
}
