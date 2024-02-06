# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

MY_PN="RHVoice"
MY_P="${MY_PN}-${PV}"
SANITIZERS_COMMIT="99e159ec9bc8dd362b08d18436bd40ff0648417b"
DESCRIPTION="TTS engine with extended languages support"
HOMEPAGE="
	https://rhvoice.org
	https://github.com/RHVoice/RHVoice
"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${MY_P}.tar.gz
	https://github.com/arsenm/sanitizers-cmake/archive/${SANITIZERS_COMMIT}.tar.gz -> ${MY_P}-sanitizers.tar.gz
"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD GPL-2 GPL-3+ LGPL-2.1+"
KEYWORDS="~amd64 ~x86"
IUSE="ao dbus portaudio +pulseaudio +speech-dispatcher"
SLOT="0"
REQUIRED_USE="|| ( ao portaudio pulseaudio )"

COMMON_DEPEND="
	dev-libs/boost:=
	ao? ( media-libs/libao )
	dbus? (
		dev-libs/glib:2[dbus]
		dev-libs/libsigc++:2
		>=dev-cpp/glibmm-2.66.1:2
	)
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-libs/libpulse )
	speech-dispatcher? ( app-accessibility/speech-dispatcher )
"
RDEPEND="${COMMON_DEPEND}
	!<app-accessibility/rhvoice-1.14.0
"
DEPEND="${COMMON_DEPEND}
	dev-cpp/cli11
	dev-libs/utfcpp
"

DOCS=( README.md doc/. config/dicts )

LANGS=( en ru )
for lang in "${LANGS[@]}"; do
	IUSE+=" l10n_${lang}"
	RDEPEND+=" l10n_${lang}? ( app-dicts/rhvoice-${lang} )"
done

src_unpack() {
	default
	cd "${S}" || die

	rmdir cmake/thirdParty/sanitizers || die
	mv "${WORKDIR}"/sanitizers-cmake-${SANITIZERS_COMMIT} cmake/thirdParty/sanitizers || die
}

src_prepare() {
	cmake_src_prepare
	cmake_comment_add_subdirectory '"${thirdPartyCMakeModulesDir}/CCache"'
}

src_configure() {
	local mycmakeargs=(
		-DRHVOICE_VERSION_FROM_GIT=${PV}
		-DWITH_CLI11=ON
		-DWITH_DATA=OFF

		# src/CMakeLists.txt
		-DBUILD_CLIENT=OFF	# deprecated, use speech-dispatcher
		-DBUILD_UTILS=OFF	# fails to build because of bundled tclap
		-DBUILD_TESTS=ON	# standalone cli application
		-DBUILD_SERVICE=$(usex dbus)
		-DBUILD_SPEECHDISPATCHER_MODULE=$(usex speech-dispatcher)

		# src/audio/CMakeLists.txt
		-DWITH_LIBAO=$(usex ao)
		-DWITH_PULSE=$(usex pulseaudio)
		-DWITH_PORTAUDIO=$(usex portaudio)

		# Hardening.cmake: don't mess with flags
		-DHARDENING_PIC=OFF
		-DHARDENING_SSE2=OFF
		-DHARDENING_COMPILE_FLAGS=
		-DHARDENING_LINK_FLAGS=
		-DHARDENING_MACRODEFS=
	)

	use speech-dispatcher && \
		append-cppflags -DSPD_MAJOR=1 -DSPD_MINOR=0

	cmake_src_configure
}
