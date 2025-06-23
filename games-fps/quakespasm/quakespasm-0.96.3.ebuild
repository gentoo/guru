# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.code.sf.net/p/quakespasm/quakespasm"
else
	SRC_URI="https://download.sourceforge.net/quakespasm/Source/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

inherit desktop eapi9-ver

DESCRIPTION="A modern, cross-platform Quake game engine based on FitzQuake"
HOMEPAGE="https://quakespasm.sourceforge.net/"

LICENSE="GPL-2+"
SLOT="0"
IUSE="flac mikmod modplug mp3 opus vorbis"

DEPEND="
	media-libs/libsdl2[opengl]
	media-libs/libglvnd
	flac? ( media-libs/flac:= )
	mikmod? ( media-libs/libmikmod )
	modplug? ( media-libs/libmodplug )
	mp3? ( media-sound/mpg123 )
	opus? ( media-libs/opusfile )
	vorbis? ( media-libs/libvorbis )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( Quakespasm.html Quakespasm.txt Quakespasm-Music.txt )

PATCHES=(
	"${FILESDIR}"/${PN}-0.96.3-cflags.patch
	"${FILESDIR}"/${P}-mkpak-portable-shell.patch # https://github.com/sezero/quakespasm/pull/127
)

src_compile() {
	local emakeargs=(
		COMMON_LIBS="-lOpenGL -lm"
		LDFLAGS="${LDFLAGS}"
		DO_USERDIRS=1
		MP3LIB=mpg123
		STRIP="$(type -P true)"
		USE_SDL2=1
		USE_CODEC_FLAC=$(usex flac 1 0)
		USE_CODEC_MIKMOD=$(usex mikmod 1 0)
		USE_CODEC_MODPLUG=$(usex modplug 1 0)
		USE_CODEC_MP3=$(usex mp3 1 0)
		USE_CODEC_VORBIS=$(usex vorbis 1 0)
		USE_CODEC_OPUS=$(usex opus 1 0)
	)

	emake -C Quake "${emakeargs[@]}"
	emake -C Misc/qs_pak
}

src_install() {
	dobin Quake/quakespasm

	insinto /usr/share/quakespasm
	doins Misc/qs_pak/quakespasm.pak

	insinto /usr/share/metainfo
	doins Linux/net.sourceforge.quakespasm.Quakespasm.appdata.xml

	domenu Linux/net.sourceforge.quakespasm.Quakespasm.desktop

	newicon Misc/QuakeSpasm_512.png net.sourceforge.quakespasm.Quakespasm.png

	einstalldocs
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]] || ver_replacing -lt 0.96.3; then
		elog
		elog "Please note that quakespasm doesn't support system-wide game data."
		elog "In order to play, you must copy game data files into"
		elog "\"~/.quakespasm/\" directory."
		elog
		elog "It is also recommended to copy quakespasm.pak as it contains default"
		elog "config, custom console background and other minor features:"
		elog "cp \"${EROOT}/usr/share/quakespasm/quakespasm.pak\" ~/.quakespasm/"
		elog
	fi
}
