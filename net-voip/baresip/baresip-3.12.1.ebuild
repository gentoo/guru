# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Baresip is a portable and modular SIP User-Agent"
HOMEPAGE="https://github.com/baresip/baresip"
SRC_URI="https://github.com/baresip/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="aac acip alsa amr aptx aom codec2 console dbus echo evdev ffmpeg gstreamer
	  gtk3 jack httpd httpreq mpa mqtt opus pipewire portaudio pulseaudio sdl
	  serreg snapshot sndfile spandsp static-libs syslog tcpcontrol v4l video vpx webrtc X"

RE_PVF="$(ver_cut 1-2)*"

DEPEND="
	dev-libs/openssl:0=
	=net-voip/re-${RE_PVF}
	sys-libs/zlib
	aac? ( media-libs/fdk-aac )
	alsa? ( media-libs/alsa-lib )
	amr? ( media-libs/opencore-amr )
	aom? ( media-libs/libaom )
	aptx? ( media-libs/libopenaptx )
	codec2? ( media-libs/codec2 )
	dbus? (
		dev-util/gdbus-codegen
		sys-apps/dbus
	)
	ffmpeg? ( media-video/ffmpeg )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
		media-libs/gst-plugins-good:1.0
	)
	gtk3? ( x11-libs/gtk+:3 )
	jack? ( virtual/jack )
	mpa? (
		media-sound/twolame
		media-sound/mpg123
		media-libs/speexdsp
	)
	mqtt? ( app-misc/mosquitto )
	opus? ( media-libs/opus )
	pipewire? ( media-video/pipewire )
	snapshot? ( media-libs/libpng )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-libs/libpulse )
	sdl? ( media-libs/libsdl2 )
	sndfile? ( media-libs/libsndfile )
	spandsp? ( media-libs/spandsp )
	v4l? ( media-libs/libv4l )
	vpx? ( media-libs/libvpx )
	webrtc? ( media-plugins/gst-plugins-webrtc )
	X? ( x11-libs/libX11 )
	"

RDEPEND="${DEPEND}"

src_configure() {
	use aac && MODULES+="aac;"
	use acip && MODULES+="ebuacip;"
	use alsa && MODULES+="alsa;"
	use amr && MODULES+="amr;"
	use aom && MODULES+="av1;"
	use aptx && MODULES+="aptx;"
	use codec2 && MODULES+="codec2;"
	use console && MODULES+="cons;"
	use dbus && MODULES+="ctrl_dbus;"
	use evdev && MODULES+="evdev;"
	use echo && MODULES+="echo;"
	use gtk3 && MODULES+="gtk;"
	use gstreamer && MODULES+="gst;"
	use httpd && MODULES+="httpd;"
	use httpreq && MODULES+="httpreq;"
	use ffmpeg && MODULES+="avcodec;avfilter;avformat;selfview;swscale;"
	use jack && MODULES+="jack;"
	use mpa && MODULES+="mpa;"
	use mqtt && MODULES+="mqtt;"
	use opus && MODULES+="opus;opus_multistream;"
	use pipewire && MODULES+="pipewire;"
	use pulseaudio && MODULES+="pulse;"
	use portaudio && MODULES+="portaudio;"
	use serreg && MODULES+="serreg;"
	use snapshot && MODULES+="snapshot;"
	use sdl && MODULES+="sdl;"
	use sndfile && MODULES+="sndfile;"
	use spandsp && MODULES+="g722;g726;plc;"
	use syslog && MODULES+="syslog;"
	use tcpcontrol && MODULES+="ctrl_tcp;"
	use v4l && MODULES+="v4l2;"
	use video && MODULES+="vidbridge;vidinfo;"
	use vpx && MODULES+="vp8;vp9;"
	use webrtc && MODULES+="webrtc_aec;"
	use X && MODULES+="x11;"
	MODULES+="account;aubridge;auconv;aufile;auresamp;ausine;contact;debug_cmd;dtls_srtp;g711;ice;menu;mixausrc;mixminus;mwi;natpmp;netroam;pcp;presence;turn;rtcpsummary;srtp;stdio;stun;uuid;vumeter"

	local mycmakeargs=(
		-DMODULES="$MODULES"
		-DLIBRE_BUILD_STATIC=$(usex static-libs ON OFF)
	)
	cmake_src_configure
}
