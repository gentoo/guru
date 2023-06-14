# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit font

DESCRIPTION="An expressive monospaced font family"
HOMEPAGE="https://github.com/intel/intel-one-mono"
SRC_URI="
	otf? ( https://github.com/intel/${PN}/releases/download/V${PV}/otf.zip -> ${P}-otf.zip )
	ttf? ( https://github.com/intel/${PN}/releases/download/V${PV}/ttf.zip -> ${P}-ttf.zip )
"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+otf ttf"
REQUIRED_USE="|| ( otf ttf )"

BDEPEND="app-arch/unzip"
S="${WORKDIR}"

src_install() {
	if use otf; then
		FONT_S="${S}/otf" FONT_SUFFIX="otf" font_src_install
	fi
	if use ttf; then
		FONT_S="${S}/ttf" FONT_SUFFIX="ttf" font_src_install
	fi
}
