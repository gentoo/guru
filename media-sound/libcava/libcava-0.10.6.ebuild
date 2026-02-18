# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Console-based Audio Visualizer for Alsa"
HOMEPAGE="https://github.com/LukashonakV/cava/"
SRC_URI="https://github.com/LukashonakV/cava/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/cava-${PV}"

LICENSE="MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="alsa jack +ncurses pipewire portaudio pulseaudio sdl sndio"

RDEPEND="
	dev-libs/iniparser
	sci-libs/fftw:3.0=
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
	ncurses? ( sys-libs/ncurses:= )
	pipewire? ( media-video/pipewire:= )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-libs/libpulse )
	sdl? (
		media-libs/libglvnd
		media-libs/libsdl2[opengl,video]
	)
	sndio? ( media-sound/sndio:= )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

MYMESONARGS="-Dcava_font=false"

src_prepare() {
	default

	echo ${PV} > version || die
}

src_configure() {
	meson_src_configure
}

src_compile() {
	mkdir -p "${BUILD_DIR}"/example_files || die
	cp "${S}"/example_files/config "${BUILD_DIR}"/example_files/ || die
	mkdir -p "${BUILD_DIR}"/src/output/{shaders,themes} || die
	cp "${S}"/src/output/shaders/* "${BUILD_DIR}"/src/output/shaders/ || die
	cp "${S}"/src/output/themes/* "${BUILD_DIR}"/src/output/themes/ || die

	meson_src_compile
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "A default ~/.config/cava/config will be created after initial"
		elog "use of ${PN}, see it and ${EROOT}/usr/share/doc/${PF}/README*"
		elog "for configuring audio input and more."
	elif ver_test ${REPLACING_VERSIONS##* } -lt 0.9; then
		elog "If used, the noise_reduction config option in ~/.config/cava/config needs"
		elog "to be updated from taking a float to integer (e.g. replace 0.77 with 77)."
	fi
}
