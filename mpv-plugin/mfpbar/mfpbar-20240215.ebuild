# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit mpv-plugin

RDEPEND=">=media-video/mpv-0.33.0[lua]"

DESCRIPTION="A minimalistic progressbar and osc replacement"
HOMEPAGE="https://codeberg.org/NRK/mpv-toolbox"

SRC_URI="https://codeberg.org/NRK/mpv-toolbox/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mpv-toolbox/${PN}"

LICENSE="GPL-3+"
KEYWORDS="~amd64"

MPV_PLUGIN_FILES=( mfpbar.lua )

src_install() {
	mpv-plugin_src_install
	dodoc mfpbar.conf
	dodoc README.md
}

pkg_postinst() {
	mpv-plugin_pkg_postinst
	einfo "mfpbar requires disabling the default osc."
	einfo "put 'osc=no' in your 'mpv.conf' in order to do so."
	einfo ""
	einfo "for thumbnail support install: https://github.com/po5/thumbfast"  # TODO(NRK): package thumbfast
}
