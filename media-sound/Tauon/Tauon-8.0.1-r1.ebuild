# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PLOCALES="cs de es fr_FR hu id it ja_JP nb_NO pl pt pt_BR pt_PT ru sv tr zh_CN"

PYTHON_COMPAT=( python3_{12..13} )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit desktop distutils-r1 optfeature plocale xdg

DESCRIPTION="The desktop music player of today!"
HOMEPAGE="https://tauonmusicbox.rocks/"

if [[ ${PV} == *9999 ]]; then
	EGIT_SUBMODULES=()
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Taiko2k/${PN}"
else
	SRC_URI="https://github.com/Taiko2k/Tauon/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"

PHAZOR_DEPS="
	dev-libs/miniaudio
	media-libs/flac:=
	media-libs/game-music-emu
	media-libs/libopenmpt
	media-libs/opus
	media-libs/opusfile
	media-libs/libsamplerate
	media-libs/libvorbis
	media-sound/mpg123
	media-sound/wavpack
	sci-libs/kissfft[-cpu_flags_x86_sse]
"

DEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/musicbrainzngs[${PYTHON_USEDEP}]
	dev-python/natsort[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pysdl3[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/setproctitle[${PYTHON_USEDEP}]
	dev-python/send2trash[${PYTHON_USEDEP}]
	dev-python/unidecode[${PYTHON_USEDEP}]
	media-video/ffmpeg
	media-libs/mutagen[${PYTHON_USEDEP}]
	media-libs/sdl3-image

	${PHAZOR_DEPS}
"

RDEPEND="
	${DEPEND}

	dev-libs/libayatana-appindicator
	media-sound/mpg123-base
	x11-libs/libnotify
"

BDEPEND="sys-devel/gettext"

PATCHES=(
	"${FILESDIR}/${PN}-7.9.0-phazor-build.patch"
	"${FILESDIR}/${PN}-8.0.1-fix-locale-path.patch"
)

src_compile() {
	distutils-r1_src_compile

	build_locale() {
		msgfmt -o "locale/${1}/LC_MESSAGES/tauon.mo" "locale/${1}/LC_MESSAGES/tauon.po" || die
	}

	plocale_for_each_locale build_locale
}

python_install() {
	distutils-r1_python_install

	install_locale() {
		insinto "/usr/share/locale/${1}/LC_MESSAGES"
		doins "locale/${1}/LC_MESSAGES/tauon.mo"
	}

	plocale_for_each_locale install_locale

	sed -i 's/Exec=tauon/Exec=tauonmb/g' extra/tauonmb.desktop || die
	domenu extra/tauonmb.desktop
	doicon -s scalable extra/tauonmb.svg

}

pkg_postinst() {
	optfeature "Chinese searches support" app-i18n/opencc[python]
	optfeature "last fm support" dev-python/pylast
	optfeature "PLEX support" dev-python/plexapi
	optfeature "Spotify support" dev-python/tekore

	xdg_pkg_postinst
}
