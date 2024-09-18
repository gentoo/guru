# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit cmake desktop xdg

DESCRIPTION="Software modular synth"
HOMEPAGE="https://www.bespokesynth.com/"
SRC_URI="https://github.com/BespokeSynth/BespokeSynth/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

JUCE_COMMIT="2a27ebcfae7ca7f6eb62b29d5f002ceefdaadbdb"
SRC_URI+=" https://github.com/juce-framework/JUCE/archive/${JUCE_COMMIT}.tar.gz -> ${PN}-JUCE-${JUCE_COMMIT}.tar.gz"
READERWRITER_COMMIT="8e7627d18c2108aca178888d88514179899a044f"
SRC_URI+=" https://github.com/cameron314/readerwriterqueue/archive/${READERWRITER_COMMIT}.tar.gz -> ${PN}-readerwriterqueue-${READERWRITER_COMMIT}.tar.gz"
TUNINGLIBRARY_COMMIT="eb8617be49ac3c2436cf54de6bff94a1b1c94acf"
SRC_URI+=" https://github.com/surge-synthesizer/tuning-library/archive/${TUNINGLIBRARY_COMMIT}.tar.gz -> ${PN}-tuning-library-${TUNINGLIBRARY_COMMIT}.tar.gz"
ABLETON_COMMIT="a4e4c2f3e598e28e5bea90002f954b997b8c8c53"
SRC_URI+=" https://github.com/Ableton/link/archive/${ABLETON_COMMIT}.tar.gz -> ${PN}-ableton-link-${ABLETON_COMMIT}.tar.gz"
ODDSOUND_COMMIT="fcfaa59a043d515d288c9d587bf61a0a7d7571a8"
SRC_URI+=" https://github.com/ODDSound/MTS-ESP/archive/${ODDSOUND_COMMIT}.tar.gz -> ${PN}-oddsound-mts-${ODDSOUND_COMMIT}.tar.gz"
ASIO_COMMIT="c465349fa5cd91a64bb369f5131ceacab2c0c1c3"
SRC_URI+=" https://github.com/chriskohlhoff/asio/archive/${ASIO_COMMIT}.tar.gz -> ${PN}-asio-${ASIO_COMMIT}.tar.gz"

S="${WORKDIR}/BespokeSynth-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/pybind11
	dev-libs/jsoncpp
	dev-cpp/asio
	>=virtual/jack-2
	x11-libs/libXrandr
"

PATCHES=(
	"${FILESDIR}/${P}-find-jsoncpp.patch"
)

src_prepare() {
	rmdir "${S}/libs/JUCE" || die
	mv "${WORKDIR}/JUCE-${JUCE_COMMIT}" "${S}/libs/JUCE" || die
	rmdir "${S}/libs/readerwriterqueue" || die
	mv "${WORKDIR}/readerwriterqueue-${READERWRITER_COMMIT}" "${S}/libs/readerwriterqueue" || die
	rmdir "${S}/libs/pybind11" || die
	#mv "${WORKDIR}/JUCE-${JUCE_COMMIT}" "${S}/libs/JUCE" || die
	rmdir "${S}/libs/tuning-library" || die
	mv "${WORKDIR}/tuning-library-${TUNINGLIBRARY_COMMIT}" "${S}/libs/tuning-library" || die
	rmdir "${S}/libs/ableton-link" || die
	mv "${WORKDIR}/link-${ABLETON_COMMIT}" "${S}/libs/ableton-link" || die

	# patching out build dependency for dev-cpp/asio
	#TODO: couldn't figure out how to have ableton-link build without asio-standalone.
	# It doesn't want to use 'dev-cpp/asio' it seems.
	# eapply "${FILESDIR}/ableton-link-dependencies.patch"
	rmdir "${S}/libs/ableton-link/modules/asio-standalone" || die
	mv "${WORKDIR}/asio-${ASIO_COMMIT}" "${S}/libs/ableton-link/modules/asio-standalone" || die

	rmdir "${S}/libs/oddsound-mts/MTS-ESP" || die
	mv "${WORKDIR}/MTS-ESP-${ODDSOUND_COMMIT}" "${S}/libs/oddsound-mts/MTS-ESP" || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"-DBESPOKE_SYSTEM_PYBIND11=TRUE"
		"-DBESPOKE_SYSTEM_JSONCPP=TRUE"
		"-DCMAKE_BUILD_TYPE=Release"
		"-DCMAKE_INSTALL_PREFIX=/usr"
		"-DCMAKE_SKIP_RPATH=ON"
	)
	cmake_src_configure
}

src_install() {
	DESTDIR="/usr/share/BespokeSynth"

	# Install libraries
	dolib.so "${WORKDIR}/BespokeSynth-${PV}_build/libs/freeverb/libfreeverb.so"
	dolib.so "${WORKDIR}/BespokeSynth-${PV}_build/libs/oddsound-mts/liboddsound-mts.so"
	dolib.so "${WORKDIR}/BespokeSynth-${PV}_build/libs/psmove/libpsmove.so"
	dolib.so "${WORKDIR}/BespokeSynth-${PV}_build/libs/push2/libpush2.so"
	dolib.so "${WORKDIR}/BespokeSynth-${PV}_build/libs/xwax/libxwax.so"
	dolib.so "${WORKDIR}/BespokeSynth-${PV}_build/libs/nanovg/libnanovg.so"

	# Create a new directory for bespoke to live in
	dodir ${DESTDIR}
	into ${DESTDIR}

	# It seems the executable really wants to be where the resource directory is.
	dobin "${WORKDIR}/BespokeSynth-${PV}_build/Source/BespokeSynth_artefacts/RelWithDebInfo/BespokeSynth"

	# Install auxilary files
	insinto /usr/share/BespokeSynth
	doins -r "${WORKDIR}/BespokeSynth-${PV}_build/Source/BespokeSynth_artefacts/RelWithDebInfo/resource"

	dosym -r ${DESTDIR}/bin/BespokeSynth /usr/bin/BespokeSynth

	# Adding icon and desktop settings
	doicon -s 512 "${WORKDIR}/BespokeSynth-${PV}/bespoke_icon.png"
	domenu "${WORKDIR}/BespokeSynth-${PV}/scripts/installer_linux/BespokeSynth.desktop"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
