# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Iconic font aggregator, collection, & patcher. 3,600+ icons, 50+ patched fonts: Hack, Source Code Pro, more. Glyph collections: Font Awesome, Material Design Icons, Octicons, & more"
IUSE="0xproto 3270 agave anonymouspro arimo aurulentsansmono bigblueterminal bitstreamverasansmono
cascadiacode cascadiamono codenewroman comicshannsmono commitmono cousine d2coding daddytimemono
dejavusansmono droidsansmono envycoder fantasquesansmono firacode firamono geistmono gomono gohu
hack hasklig heavydata hermit iawriter ibmplexmono inconsolata inconsolatago inconsolatalgc
intelonemono iosevka iosevkaterm iosevkatermslab jetbrainsmono lekton liberationmono lilex
martianmono meslo monaspace monofur monoid mononoki mplus nerdfontssymbolsonly noto opendyslexic
overpass profont proggyclean robotomono sharetechmono sourcecodepro spacemono terminus tinos ubuntu
ubuntumono victormono"
REQUIRED_USE="|| ( 0xproto 3270 agave anonymouspro arimo aurulentsansmono bigblueterminal bitstreamverasansmono
cascadiacode cascadiamono codenewroman comicshannsmono commitmono cousine d2coding daddytimemono
dejavusansmono droidsansmono envycoder fantasquesansmono firacode firamono geistmono gomono gohu
hack hasklig heavydata hermit iawriter ibmplexmono inconsolata inconsolatago inconsolatalgc
intelonemono iosevka iosevkaterm iosevkatermslab jetbrainsmono lekton liberationmono lilex
martianmono meslo monaspace monofur monoid mononoki mplus nerdfontssymbolsonly noto opendyslexic
overpass profont proggyclean robotomono sharetechmono sourcecodepro spacemono terminus tinos ubuntu
ubuntumono victormono )"
HOMEPAGE="https://github.com/ryanoasis/nerd-fonts"
SRC_URI="
	0xproto? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/0xProto.tar.xz -> 0xProto-${PV}.tar.xz )
	3270? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/3270.tar.xz -> 3270-${PV}.tar.xz )
	agave? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Agave.tar.xz -> Agave-${PV}.tar.xz )
	anonymouspro? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/AnonymousPro.tar.xz -> AnonymousPro-${PV}.tar.xz )
	arimo? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Arimo.tar.xz -> Arimo-${PV}.tar.xz )
	aurulentsansmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/AurulentSansMono.tar.xz -> AurulentSansMono-${PV}.tar.xz )
	bigblueterminal? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/BigBlueTerminal.tar.xz -> BigBlueTerminal-${PV}.tar.xz )
	bitstreamverasansmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/BitstreamVeraSansMono.tar.xz -> BitstreamVeraSansMono-${PV}.tar.xz )
	cascadiacode? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/CascadiaCode.tar.xz -> CascadiaCode-${PV}.tar.xz )
	cascadiamono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/CascadiaMono.tar.xz -> CascadiaMono-${PV}.tar.xz )
	codenewroman? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/CodeNewRoman.tar.xz -> CodeNewRoman-${PV}.tar.xz )
	comicshannsmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/ComicShannsMono.tar.xz -> ComicShannsMono-${PV}.tar.xz )
	commitmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/CommitMono.tar.xz -> CommitMono-${PV}.tar.xz )
	cousine? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Cousine.tar.xz -> Cousine-${PV}.tar.xz )
	d2coding? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/D2Coding.tar.xz -> D2Coding-${PV}.tar.xz )
	daddytimemono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/DaddyTimeMono.tar.xz -> DaddyTimeMono-${PV}.tar.xz )
	dejavusansmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/DejaVuSansMono.tar.xz -> DejaVuSansMono-${PV}.tar.xz )
	droidsansmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/DroidSansMono.tar.xz -> DroidSansMono-${PV}.tar.xz )
	envycoder? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/EnvyCodeR.tar.xz -> EnvyCodeR-${PV}.tar.xz )
	fantasquesansmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/FantasqueSansMono.tar.xz -> FantasqueSansMono-${PV}.tar.xz )
	firacode? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/FiraCode.tar.xz -> FiraCode-${PV}.tar.xz )
	firamono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/FiraMono.tar.xz -> FiraMono-${PV}.tar.xz )
	geistmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/GeistMono.tar.xz -> GeistMono-${PV}.tar.xz )
	gomono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Go-Mono.tar.xz -> Go-Mono-${PV}.tar.xz )
	gohu? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Gohu.tar.xz -> Gohu-${PV}.tar.xz )
	hack? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Hack.tar.xz -> Hack-${PV}.tar.xz )
	hasklig? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Hasklig.tar.xz -> Hasklig-${PV}.tar.xz )
	heavydata? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/HeavyData.tar.xz -> HeavyData-${PV}.tar.xz )
	hermit? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Hermit.tar.xz -> Hermit-${PV}.tar.xz )
	iawriter? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/iA-Writer.tar.xz -> iA-Writer-${PV}.tar.xz )
	ibmplexmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/IBMPlexMono.tar.xz -> IBMPlexMono-${PV}.tar.xz )
	inconsolata? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Inconsolata.tar.xz -> Inconsolata-${PV}.tar.xz )
	inconsolatago? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/InconsolataGo.tar.xz -> InconsolataGo-${PV}.tar.xz )
	inconsolatalgc? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/InconsolataLGC.tar.xz -> InconsolataLGC-${PV}.tar.xz )
	intelonemono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/IntelOneMono.tar.xz -> IntelOneMono-${PV}.tar.xz )
	iosevka? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Iosevka.tar.xz -> Iosevka-${PV}.tar.xz )
	iosevkaterm? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/IosevkaTerm.tar.xz -> IosevkaTerm-${PV}.tar.xz )
	iosevkatermslab? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/IosevkaTermSlab.tar.xz -> IosevkaTermSlab-${PV}.tar.xz )
	jetbrainsmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/JetBrainsMono.tar.xz -> JetBrainsMono-${PV}.tar.xz )
	lekton? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Lekton.tar.xz -> Lekton-${PV}.tar.xz )
	liberationmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/LiberationMono.tar.xz -> LiberationMono-${PV}.tar.xz )
	lilex? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Lilex.tar.xz -> Lilex-${PV}.tar.xz )
	martianmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/MartianMono.tar.xz -> MartianMono-${PV}.tar.xz )
	meslo? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Meslo.tar.xz -> Meslo-${PV}.tar.xz )
	monaspace? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Monaspace.tar.xz -> Monaspace-${PV}.tar.xz )
	monofur? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Monofur.tar.xz -> Monofur-${PV}.tar.xz )
	monoid? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Monoid.tar.xz -> Monoid-${PV}.tar.xz )
	mononoki? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Mononoki.tar.xz -> Mononoki-${PV}.tar.xz )
	mplus? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/MPlus.tar.xz -> MPlus-${PV}.tar.xz )
	nerdfontssymbolsonly? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/NerdFontsSymbolsOnly.tar.xz -> NerdFontsSymbolsOnly-${PV}.tar.xz )
	noto? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Noto.tar.xz -> Noto-${PV}.tar.xz )
	opendyslexic? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/OpenDyslexic.tar.xz -> OpenDyslexic-${PV}.tar.xz )
	overpass? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Overpass.tar.xz -> Overpass-${PV}.tar.xz )
	profont? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/ProFont.tar.xz -> ProFont-${PV}.tar.xz )
	proggyclean? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/ProggyClean.tar.xz -> ProggyClean-${PV}.tar.xz )
	robotomono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/RobotoMono.tar.xz -> RobotoMono-${PV}.tar.xz )
	sharetechmono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/ShareTechMono.tar.xz -> ShareTechMono-${PV}.tar.xz )
	sourcecodepro? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/SourceCodePro.tar.xz -> SourceCodePro-${PV}.tar.xz )
	spacemono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/SpaceMono.tar.xz -> SpaceMono-${PV}.tar.xz )
	terminus? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Terminus.tar.xz -> Terminus-${PV}.tar.xz )
	tinos? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Tinos.tar.xz -> Tinos-${PV}.tar.xz )
	ubuntu? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/Ubuntu.tar.xz -> Ubuntu-${PV}.tar.xz )
	ubuntumono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/UbuntuMono.tar.xz -> UbuntuMono-${PV}.tar.xz )
	victormono? ( https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/VictorMono.tar.xz -> VictorMono-${PV}.tar.xz )
"

RDEPEND="
	firacode? ( !media-fonts/firacode-nerdfont )
	iosevka? ( !media-fonts/iosevka-nerdfont )
	jetbrainsmono? ( !media-fonts/jetbrainsmono-nerdfont )
	robotomono? ( !media-fonts/robotomono-nerdfont )
	ubuntumono? ( !media-fonts/ubuntumono-nerdfont )
"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}"

FONT_SUFFIX="ttf otf"


# From font.eclass
src_install() {
	local dir suffix commondoc

	if [[ -n ${FONT_OPENTYPE_COMPAT} ]] && in_iuse opentype-compat && use opentype-compat ; then
		font_wrap_opentype_compat
	fi

	if [[ $(declare -p FONT_S 2>/dev/null) == "declare -a"* ]]; then
		# recreate the directory structure if FONT_S is an array
		for dir in "${FONT_S[@]}"; do
			pushd "${dir}" > /dev/null || die "pushd ${dir} failed"
			insinto "${FONTDIR}/${dir#"${S}"}"
			for suffix in ${FONT_SUFFIX}; do
				if compgen -G "*.${suffix}" > /dev/null; then
					doins *.${suffix}
				fi
			done
			font_xfont_config "${dir}"
			popd > /dev/null || die
		done
	else
		pushd "${FONT_S:-${S}}" > /dev/null \
			|| die "pushd ${FONT_S:-${S}} failed"
		insinto "${FONTDIR}"
		for suffix in ${FONT_SUFFIX}; do
			if compgen -G "*.${suffix}" > /dev/null; then
				doins *.${suffix}
			fi
		done
		font_xfont_config
		popd > /dev/null || die
	fi

	font_fontconfig

	einstalldocs

	# install common docs
	for commondoc in COPYRIGHT FONTLOG.txt; do
		[[ -s ${commondoc} ]] && dodoc ${commondoc}
	done
}
