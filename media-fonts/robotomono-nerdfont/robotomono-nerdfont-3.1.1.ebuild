# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="A free and open-source typeface for developers"
HOMEPAGE="https://github.com/ryanoasis/nerd-fonts"
SRC_URI="https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/RobotoMono.tar.xz -> ${P}.gh.tar.xz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"
FONT_SUFFIX="ttf"

pkg_postinst() {
	ewarn "Upstream has recently made some major changes since version 3.0.0."
	ewarn "The older Material Design Icon codepoints have been dropped."
	ewarn "See issue 1059, comment 1404891287 at upstream for a translation table."
	ewarn "More information can be found here:"
	ewarn "https://github.com/ryanoasis/nerd-fonts/tree/v3.0.0"
}
