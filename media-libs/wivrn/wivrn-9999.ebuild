# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib fcaps flag-o-matic xdg

DESCRIPTION="WiVRn OpenXR streaming"
HOMEPAGE="https://github.com/WiVRn/WiVRn"

LICENSE="GPL-3 Apache-2.0 MIT"
SLOT="0"
IUSE="debug gui nvenc +pipewire pulseaudio systemd vaapi wireshark-plugins x264"
REQUIRED_USE="|| ( nvenc vaapi x264 )"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WiVRn/WiVRn.git"
	EGIT_MIN_CLONE_TYPE="single+tags"
	MONADO_REPO_URI="https://gitlab.freedesktop.org/monado/monado.git"
else
	SRC_URI="
		https://github.com/WiVRn/WiVRn/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/WiVRn/WiVRn/releases/download/v${PV}/server-build-deps.tar.xz -> ${P}-server-build-deps.tar.xz"
	KEYWORDS="~amd64"
fi

RDEPEND="
	app-arch/libarchive
	dev-libs/glib
	dev-libs/libbsd
	dev-libs/openssl
	gnome-base/librsvg
	media-libs/libpng
	media-libs/openxr-loader
	net-dns/avahi
	x11-libs/libnotify
	|| (
		sys-apps/systemd
		sys-auth/elogind
	)
	gui? (
		dev-libs/qcoro[qml]
		kde-frameworks/kcoreaddons:6
		kde-frameworks/ki18n:6
		kde-frameworks/kiconthemes:6
		kde-frameworks/kirigami:6
		kde-frameworks/qqc2-desktop-style:6
	)
	pipewire? (
		media-video/pipewire
	)
	pulseaudio? (
		media-libs/libpulse
	)
	systemd? (
		sys-apps/systemd
	)
	vaapi? ( || (
		media-video/ffmpeg[libdrm(-),vaapi]
		media-video/ffmpeg[drm(-),vaapi]
	) )
	x264? (
		media-libs/x264
	)
	wireshark-plugins? (
		!=net-analyzer/wireshark-4.6.0
		net-analyzer/wireshark
	)
"
DEPEND="
	${RDEPEND}

	dev-libs/boost
	dev-cpp/cli11
	dev-cpp/eigen
	dev-cpp/nlohmann_json
	dev-util/vulkan-headers
"
BDEPEND="
	dev-util/glslang
	dev-util/gdbus-codegen
"

if [[ ${PV} == 9999 ]]; then
	src_unpack() {
		git-r3_src_unpack
		default_src_unpack

		# export those before Monado is checked out
		export GIT_DESC=$(git -C "${EGIT_DIR}" describe "${EGIT_VERSION}" --tags --always)
		export GIT_COMMIT=${EGIT_VERSION}

		# Only use those for the main repo
		unset EGIT_BRANCH EGIT_COMMIT
		local MONADO_COMMIT=$(cat "${P}/monado-rev")
		git-r3_fetch "${MONADO_REPO_URI}" "${MONADO_COMMIT}"
		git-r3_checkout "${MONADO_REPO_URI}" "${WORKDIR}/monado-src"
	}

	src_prepare() {
		default_src_prepare
		eapply --directory="${WORKDIR}/monado-src" "${WORKDIR}/${P}/patches/monado"/*
		cmake_src_prepare
	}
else
	src_unpack() {
		default_src_unpack
		cd "${WORKDIR}"
		mv "WiVRn-${PV}" "${P}"
	}
fi

multilib_src_configure() {
	use debug || append-cflags "-DNDEBUG"
	use debug || append-cxxflags "-DNDEBUG"
	if [[ ${PV} != 9999 ]]; then
		GIT_DESC=v${PV}
		GIT_COMMIT=v${PV}
	fi
	local mycmakeargs=(
		-DGIT_DESC=${GIT_DESC}
		-DGIT_COMMIT=${GIT_COMMIT}
		-DWIVRN_BUILD_CLIENT=OFF
		-DWIVRN_BUILD_SERVER=$(multilib_is_native_abi && echo ON || echo OFF)
		-DWIVRN_BUILD_SERVER_LIBRARY=ON
		-DWIVRN_OPENXR_MANIFEST_TYPE=relative
		-DWIVRN_OPENXR_MANIFEST_ABI=$(multilib_is_native_abi && echo OFF || echo ON)
		-DWIVRN_BUILD_DASHBOARD=$(multilib_native_usex gui)
		-DWIVRN_BUILD_DISSECTOR=$(multilib_native_usex wireshark-plugins)
		-DWIVRN_BUILD_WIVRNCTL=$(multilib_is_native_abi && echo ON || echo OFF)
		-DWIVRN_FEATURE_STEAMVR_LIGHTHOUSE=ON
		-DWIVRN_USE_PIPEWIRE=$(multilib_native_usex pipewire)
		-DWIVRN_USE_PULSEAUDIO=$(multilib_native_usex pulseaudio)
		-DWIVRN_USE_NVENC=$(multilib_native_usex nvenc)
		-DWIVRN_USE_VAAPI=$(multilib_native_usex vaapi)
		-DWIVRN_USE_VULKAN_ENCODE=ON
		-DWIVRN_USE_X264=$(multilib_native_usex x264)
		-DWIVRN_USE_SYSTEMD=$(multilib_native_usex systemd)
		-DWIVRN_USE_SYSTEM_OPENXR=ON
		-DWIVRN_USE_SYSTEM_BOOST=ON
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DFETCHCONTENT_BASE_DIR="${WORKDIR}"
		-DENABLE_COLOURED_OUTPUT=OFF
	)

	cmake_src_configure
}

multilib_src_install() {
	cmake_src_install

	newenvd - "50${PN}" <<-_EOF_
PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
	_EOF_
}

pkg_postinst()
{
	fcaps cap_sys_nice usr/bin/wivrn-server
	xdg_pkg_postinst
	elog "WiVRn requires a compatible client on VR headset to run."
	if [[ ${PV} == 9999 ]]; then
		elog "For most headsets it can be downloaded from CI artifacts on https://github.com/WiVRn/WiVRn/actions/workflows/Build.yml"
	else
		elog "For most headsets it can be downloaded on https://github.com/WiVRn/WiVRn/releases/tag/v${PV}"
	fi
}
