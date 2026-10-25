# Copyright 2023-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Patched font collection with a high number of glyphs (icons)"
HOMEPAGE="https://github.com/ryanoasis/nerd-fonts"
S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

# one can easily get the font list of the latest release by:
# gh release --repo ryanoasis/nerd-fonts view "$(
# gh release --repo ryanoasis/nerd-fonts list --limit 1 --order desc --json tagName --jq '.[].tagName')" |
# sed -nE 's/^asset:\s+(\S+)\.tar\.xz/\1/p' | sort | uniq

# after that, the font changes can be easily seen by diffing the two ebuild's data
# diff <(bash -c 'source ./nerdfonts-3.4.0.ebuild >/dev/null 2>&1; tr "[:space:]" "\n" <<< ${FONTS[@]} | sort |
# uniq') <(bash -c 'source ./nerdfonts-3.5.1.ebuild >/dev/null 2>&1; tr "[:space:]" "\n" <<< ${FONTS[@]} | sort |
# uniq')

FONTS=(
	0xProto 3270 AdwaitaMono Agave AnnotationMono AnonymousPro Arimo AtkinsonHyperlegibleMono AurulentSansMono
	BigBlueTerminal BitstreamVeraSansMono CascadiaCode CascadiaMono CodeNewRoman ComicShannsMono CommitMono Cousine
	D2Coding DaddyTimeMono DejaVuSansMono DepartureMono DroidSansMono EnvyCodeR FantasqueSansMono FiraCode FiraMono
	GeistMono Go-Mono Gohu GoogleSansCode Hack Hasklig HeavyData Hermit iA-Writer IBMPlexMono Inconsolata InconsolataGo
	InconsolataLGC IntelOneMono Iosevka IosevkaTerm IosevkaTermSlab JetBrainsMono Lekton LiberationMono Lilex
	MartianMono Meslo Monaspace Monofur Monoid Mononoki MPlus NerdFontsSymbolsOnly Noto OpenDyslexic Overpass ProFont
	ProggyClean Recursive RobotoMono ShareTechMono SourceCodePro SpaceMono Terminus Tinos Ubuntu UbuntuMono UbuntuSans
	VictorMono ZedMono
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
