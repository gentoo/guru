# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg meson

DESCRIPTION="An expanded Adwaita-styled companion icon theme"
HOMEPAGE="https://github.com/somepaulo/MoreWaita"

LICENSE="GPL-3+"
SLOT="0"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/somepaulo/MoreWaita"
else
	SRC_URI="https://github.com/somepaulo/MoreWaita/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

# this ebuild does not install binaries
RESTRICT="binchecks strip"
RDEPEND="x11-themes/adwaita-icon-theme"
