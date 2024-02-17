# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Baresip is a portable and modular SIP User-Agent"
HOMEPAGE="https://github.com/baresip/baresip"
SRC_URI="https://github.com/baresip/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

IUSE="aac alsa amr aptx aom codec2 ffmpeg gst gtk3 jack mqtt mpa opus ssl png portaudio pulseaudio pipewire sdl sndfile spandsp vpx X"

DEPEND="
	~net-voip/re-${PV}
	aac? ( media-libs/fdk-aac )
	alsa? ( media-libs/alsa-lib )
	amr? ( media-libs/opencore-amr )
	aptx? ( media-libs/libopenaptx )
	aom? ( media-libs/libaom )
	codec2? ( media-libs/codec2 )
	ffmpeg? ( media-video/ffmpeg )
	gst? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
		media-libs/gst-plugins-good:1.0
	)
	gtk3? ( x11-libs/gtk+:3 )
	jack? ( virtual/jack )
	mqtt? ( app-misc/mosquitto )
	mpa? (
		media-sound/twolame
		media-sound/mpg123
		media-libs/speexdsp
	)
	ssl? ( dev-libs/openssl:0= )
	opus? ( media-libs/opus )
	png? ( media-libs/libpng )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-libs/libpulse )
	pipewire? ( media-video/pipewire )
	sdl? ( media-libs/libsdl2 )
	sndfile? ( media-libs/libsndfile )
	spandsp? ( media-libs/spandsp )
	vpx? ( media-libs/libvpx )
	X? ( x11-libs/libX11 )
	"

RDEPEND="${DEPEND}"
