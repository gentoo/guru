# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="A free and open-source typeface for developers"
HOMEPAGE="https://github.com/ryanoasis/nerd-fonts"
SRC_URI="https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/JetBrainsMono.zip -> ${P}.zip"

S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

FONT_SUFFIX="ttf"
