# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Black minimal theme for Nulloy music player (that one with the waveform)"
HOMEPAGE="https://gitlab.com/vitaly-zdanevich/nulloy-theme-night"
SRC_URI="https://gitlab.com/vitaly-zdanevich/nulloy-theme-night/-/archive/${PV}/nulloy-theme-night-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	media-sound/nulloy
	app-arch/zip
"

src_install() {
	zip night.nzs id.txt form.ui script.js

	insinto /usr/share/nulloy/skins/
	doins night.nzs
}
