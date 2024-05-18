# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-plugin optfeature

RDEPEND=">=media-video/mpv-0.33.0[lua]"

DESCRIPTION="A minimalistic progressbar and osc replacement"
HOMEPAGE="https://codeberg.org/NRK/mpv-toolbox"

SRC_URI="https://codeberg.org/NRK/mpv-toolbox/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mpv-toolbox/${PN}"

LICENSE="GPL-3+"
KEYWORDS="~amd64"

MPV_PLUGIN_FILES=( mfpbar.lua )
DOCS=( mfpbar.conf README.md )

pkg_postinst() {
	mpv-plugin_pkg_postinst
	einfo "mfpbar requires disabling the default osc."
	einfo "put 'osc=no' in your 'mpv.conf' in order to do so."
	optfeature "thumbnail support" mpv-plugin/thumbfast
}
