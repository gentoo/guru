# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Patched font collection with a high number of glyphs (icons)"
HOMEPAGE="https://github.com/ryanoasis/nerd-fonts"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

FONTS=(
	0xProto 3270 AdwaitaMono Agave AnonymousPro Arimo AtkinsonHyperlegibleMono
	AurulentSansMono BigBlueTerminal BitstreamVeraSansMono CascadiaCode
	CascadiaMono CodeNewRoman ComicShannsMono CommitMono Cousine D2Coding
	DaddyTimeMono DejaVuSansMono DepartureMono DroidSansMono EnvyCodeR
	FantasqueSansMono FiraCode FiraMono GeistMono Go-Mono Gohu Hack Hasklig
	HeavyData Hermit iA-Writer IBMPlexMono Inconsolata InconsolataGo InconsolataLGC
	IntelOneMono Iosevka IosevkaTerm IosevkaTermSlab JetBrainsMono Lekton
	LiberationMono Lilex MartianMono Meslo Monaspace Monofur Monoid Mononoki MPlus
	NerdFontsSymbolsOnly Noto OpenDyslexic Overpass ProFont ProggyClean Recursive
	RobotoMono ShareTechMono SourceCodePro SpaceMono Terminus Tinos Ubuntu
	UbuntuMono UbuntuSans VictorMono ZedMono
)
IUSE_FONTS=""
BASE_URI="https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}"
for font in ${FONTS[*]}; do
	font_use=${font,,}
	font_use=${font_use//-}
	IUSE_FONTS+=" ${font_use}"
	SRC_URI+=" ${font_use}? ( ${BASE_URI}/${font}.tar.xz -> ${font}-${PV}.tar.xz )"
done

IUSE="${IUSE_FONTS} +nerdfontssymbolsonly"
REQUIRED_USE="|| ( ${IUSE_FONTS} )"

FONT_SUFFIX=""

src_install() {
	for suffix in ttf otf; do
		if nonfatal compgen -G "*.${suffix}" > /dev/null; then
			FONT_SUFFIX+=" ${suffix}"
		fi
	done

	font_src_install
}
