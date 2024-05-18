# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Excellent terminal music player, support almost every known sound system."
HOMEPAGE="https://github.com/clangen/musikcube"
SRC_URI="https://github.com/clangen/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+alsa +libopenmpt pipewire pulseaudio +mpris portaudio sndio systemd elogind basu"

REQUIRED_USE="
	mpris? ( ^^ ( systemd elogind basu ) )
"

DEPEND="
	net-libs/libmicrohttpd:=
	sys-libs/ncurses:=
	media-libs/libogg
	media-video/ffmpeg:=
	sys-libs/zlib:=
	media-libs/libvorbis
	net-misc/curl
	media-sound/lame
	dev-libs/libev
	media-libs/taglib
	dev-cpp/asio
	libopenmpt? (
		media-libs/libopenmpt
		media-sound/mpg123
	)
	mpris? (
		|| (
			elogind? ( >=sys-auth/elogind-239 )
			systemd? ( sys-apps/systemd )
			basu? ( sys-libs/basu )
		)
	)
	pipewire? (
		media-video/pipewire:=
	)
	portaudio? (
		media-libs/portaudio
	)
	pulseaudio? (
		media-libs/libpulse
	)
	sndio? (
		media-sound/sndio:=
	)
	alsa? (
		media-libs/alsa-lib
	)
"

RDEPEND="${DEPEND}"

BDEPEND="dev-util/patchelf"

PATCHES=(
	"${FILESDIR}/musikcube-3.0.1-tinfow.patch"
)

src_configure() {
	# Gentoo users enable ccache via e.g. FEATURES=ccache or
	# other means. We don't want the build system to enable it for us.
	sed -i -e '/find_program(CCACHE_FOUND ccache)/d' CMakeLists.txt || die

	use mpris || sed -i '/pkg_check_modules.*SDBUS/d' src/plugins/mpris/CMakeLists.txt || die

	local mycmakeargs=(
		$(usex alsa '' -DLIBASOUND=LIBASOUND-NOTFOUND)
		-DENABLE_PIPEWIRE=$(usex pipewire true false)
		$(usex pulseaudio '' -DLIBPULSE=LIBPULSE-NOTFOUND)
		$(usex portaudio '' -DLIBPORTAUDIO=LIBPORTAUDIO-NOTFOUND)
		$(usex libopenmpt '' -DLIBOPENMPT=LIBOPENMPT-NOTFOUND)
		$(usex sndio '' -DLIBSNDIO=LIBSNDIO-NOTFOUND)
		-DBUILD_STANDALONE=false
	)

	if use mpris; then
		if use elogind; then
			 mycmakeargs+=( -DUSE_ELOGIND=true )
		fi
		if use basu; then
			 mycmakeargs+=( -DUSE_BASU=true )
		fi
	fi

	cmake_src_configure
}
