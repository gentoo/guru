# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="RetroArch is a frontend for emulators, game engines and media players"
HOMEPAGE="https://www.retroarch.com"

SRC_URI="https://github.com/libretro/RetroArch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="7zip alsa cg cpu_flags_arm_neon cpu_flags_arm_vfp cpu_flags_x86_sse2 cheevos debug dispmanx +egl filters ffmpeg gles2 gles3 hid jack kms libass libusb materialui network openal +opengl osmesa oss +ozone +pulseaudio +rgui sdl sdl2 +truetype +threads udev v4l2 videocore vulkan wayland +X xinerama xmb xv zlib"

REQUIRED_USE="
	|| ( alsa jack openal oss pulseaudio )
	|| ( opengl sdl sdl2 vulkan dispmanx )
	|| ( kms X wayland videocore )
	|| ( materialui ozone rgui xmb )
	alsa? ( threads )
	arm? ( gles2? ( egl ) )
	!arm? (
		egl? ( opengl )
		gles2? ( opengl )
	)
	cg? ( opengl )
	dispmanx? ( videocore arm )
	gles2? ( !cg )
	gles3? ( gles2 )
	kms? ( egl )
	libass? ( ffmpeg )
	libusb? ( hid )
	sdl? ( rgui )
	sdl2? ( rgui !sdl )
	videocore? ( arm )
	vulkan? ( amd64 )
	wayland? ( egl )
	xinerama? ( X )
	xv? ( X )
"

RDEPEND="
	alsa? ( media-libs/alsa-lib:0= )
	cg? ( media-gfx/nvidia-cg-toolkit:0= )
	arm? ( dispmanx? ( || ( media-libs/raspberrypi-userland:0 media-libs/raspberrypi-userland-bin:0 ) ) )
	ffmpeg? ( >=media-video/ffmpeg-2.1.3:0= )
	jack? ( virtual/jack:= )
	libass? ( media-libs/libass:0= )
	libusb? ( virtual/libusb:1= )
	openal? ( media-libs/openal:0= )
	opengl? ( media-libs/mesa:0=[gles2?] )
	osmesa? ( media-libs/mesa:0=[osmesa?] )
	pulseaudio? ( media-libs/libpulse:0= )
	sdl? ( >=media-libs/libsdl-1.2.10:0=[joystick] )
	sdl2? ( media-libs/libsdl2:0=[joystick] )
	truetype? ( media-libs/freetype:2= )
	udev? ( virtual/udev:0=
		X? ( x11-drivers/xf86-input-evdev:0= )
	)
	amd64? ( vulkan? ( media-libs/vulkan-loader:0= ) )
	v4l2? ( media-libs/libv4l:0= )
	wayland? ( media-libs/mesa:0=[wayland?] )
	X? (
		x11-base/xorg-server:0=
		>=x11-libs/libxkbcommon-0.4.0:0=
	)
	xinerama? ( x11-libs/libXinerama:0= )
	xv? ( x11-libs/libXv:0= )
	zlib? ( sys-libs/zlib:0= )
"

DEPEND="${RDEPEND}
	virtual/pkgconfig
"

src_configure() {
	if use cg; then
		append-ldflags -L"${EPREFIX}/"opt/nvidia-cg-toolkit/$(get_libdir)
		append-cflags  -I"${EPREFIX}/"opt/nvidia-cg-toolkit/include
	fi

	# Absolute path of the directory containing Retroarch shared libraries.
	export RETROARCH_LIB_DIR="${EPREFIX}/usr/$(get_libdir)/retroarch"

	if use filters; then
		# Replace stock defaults with Gentoo-specific defaults.
		sed -i retroarch.cfg \
			-e 's:# \(video_filter_dir =\):\1 "/'${RETROARCH_LIB_DIR}'/filters/video/":' \
			-e 's:# \(audio_filter_dir =\):\1 "/'${RETROARCH_LIB_DIR}'/filters/audio/":' \
			|| die '"sed" failed.'
	fi

	# Note that OpenVG support is hard-disabled. (See ${RDEPEND} above.)
	./configure \
		--prefix="${EPREFIX}/usr" \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--enable-dynamic \
		--disable-vg \
		$(use_enable 7zip) \
		$(use_enable alsa) \
		$(use_enable cheevos) \
		$(use_enable cg) \
		$(use_enable cpu_flags_arm_neon neon) \
		$(use_enable cpu_flags_arm_vfp floathard) \
		$(use_enable cpu_flags_x86_sse2 sse) \
		$(use_enable dispmanx) \
		$(use_enable egl) \
		$(use_enable ffmpeg) \
		$(use_enable gles2 opengles) \
		$(use_enable gles3 opengles3) \
		$(use_enable hid) \
		$(use_enable jack) \
		$(use_enable kms) \
		$(use_enable libass ssa) \
		$(use_enable libusb) \
		$(use_enable materialui) \
		$(use_enable network networking) \
		$(use_enable openal al) \
		$(use_enable opengl) \
		$(use_enable osmesa) \
		$(use_enable oss) \
		$(use_enable ozone) \
		$(use_enable pulseaudio pulse) \
		$(use_enable rgui) \
		$(use_enable sdl) \
		$(use_enable sdl2) \
		$(use_enable threads) \
		$(use_enable truetype freetype) \
		$(use_enable udev) \
		$(use_enable v4l2) \
		$(use_enable videocore) \
		$(use_enable vulkan) \
		$(use_enable wayland) \
		$(use_enable X x11) \
		$(use_enable xinerama) \
		$(use_enable xmb) \
		$(use_enable xv xvideo) \
		$(use_enable zlib)
}

src_compile() {
	emake $(usex debug "DEBUG=1" "")
	if use filters; then
		emake $(usex debug "build=debug" "build=release") -C gfx/video_filters/
		emake $(usex debug "build=debug" "build=release") -C libretro-common/audio/dsp_filters/
	fi
}

src_install() {
	# Install core files and directories.
	emake DESTDIR="${D}" install

	# Install documentation.
	dodoc README.md

	if use filters; then
		# Install video filters.
		insinto ${RETROARCH_LIB_DIR}/filters/video/
		doins "${S}"/gfx/video_filters/*.so
		doins "${S}"/gfx/video_filters/*.filt

		# Install audio filters.
		insinto ${RETROARCH_LIB_DIR}/filters/audio/
		doins "${S}"/libretro-common/audio/dsp_filters/*.dsp
	fi
}

pkg_postinst() {
	if use oss; then
		ewarn ""
		ewarn "OSS support is enabled, however it is not installed as a dependency."
		ewarn "Make sure you have OSS installed in your system."
		ewarn ""
	fi
}
