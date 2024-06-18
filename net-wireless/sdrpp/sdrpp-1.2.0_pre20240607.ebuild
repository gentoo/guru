# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

DESCRIPTION="Cross-Platform SDR Software "
HOMEPAGE="https://www.sdrpp.org/"
SRC_URI="https://github.com/AlexandreRouma/SDRPlusPlus/archive/206ce6e8c37aa7ee2e1990b80644330b6ac69b6b.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# Sources
SOURCES_IUSE="airspy airspyhf bladerf hackrf hermes plutosdr rtlsdr sdrplay soapy uhd"

SINKS_IUSE="portaudio"

IUSE="${SOURCES_IUSE} ${SINKS_IUSE}"

DEPEND="sci-libs/fftw
	media-libs/glfw
	media-libs/glew
	sci-libs/volk
	app-arch/zstd
	media-libs/rtaudio
	airspy? (
		net-wireless/airspy
	)
	airspyhf? (
		net-wireless/airspyhf
	)
	bladerf? (
		net-wireless/bladerf
	)
	hackrf? (
		net-libs/libhackrf
	)
	plutosdr? (
		net-libs/libad9361-iio
		net-libs/libiio
	)
	sdrplay? (
		net-wireless/sdrplay
	)
	soapy? (
		net-wireless/soapysdr
	)
	rtlsdr? (
		net-wireless/rtl-sdr
	)
	uhd? (
		net-wireless/uhd
	)
	portaudio? (
		media-libs/portaudio
	)
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/sdrpp-1.2.0_pre20240607-remove-compiler-flags.patch"
)

src_unpack(){
	default
	mv SDRPlusPlus* "${P}" || die
}

src_prepare(){
	if [ "${ARCH}" = "amd64" ];
	then
		eapply "${FILESDIR}/sdrpp-1.2.0_pre20240607-lib64.patch"
	fi
	cmake_src_prepare
}

src_configure(){
	mycmakeargs+=(
		-DOPT_BUILD_AIRSPY_SOURCE=$(usex airspy ON OFF)
		-DOPT_BUILD_AIRSPYHF_SOURCE=$(usex airspyhf ON OFF)
		-DOPT_BUILD_BLADERF_SOURCE=$(usex bladerf ON OFF)
		-DOPT_BUILD_HACKRF_SOURCE=$(usex hackrf ON OFF)
		-DOPT_BUILD_HERMES_SOURCE=$(usex hermes ON OFF)
		-DOPT_BUILD_PLUTOSDR_SOURCE=$(usex plutosdr ON OFF)
		-DOPT_BUILD_RTL_SDR_SOURCE=$(usex rtlsdr ON OFF)
		-DOPT_BUILD_SDRPLAY_SOURCE=$(usex sdrplay ON OFF)
		-DOPT_BUILD_SOAPY_SOURCE=$(usex soapy ON OFF)
		-DOPT_BUILD_USRP_SOURCE=$(usex uhd ON OFF)
		-DOPT_BUILD_NEW_PORTAUDIO_SINK=$(usex portaudio ON OFF)
		-DOPT_BUILD_PORTAUDIO_SINK=$(usex portaudio ON OFF)
		-DOPT_BUILD_DISCORD_PRESENCE="OFF"
	)
	cmake_src_configure
}
