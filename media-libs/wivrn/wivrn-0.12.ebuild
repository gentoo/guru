EAPI=7

DESCRIPTION="WiVRn OpenXR streaming"
HOMEPAGE="https://github.com/meumeu/WiVRn"
SLOT="0"
LICENSE="GPL-3 Apache-2.0 MIT"

IUSE="nvenc systemd vaapi wireshark-plugins x264"
REQUIRED_USE="|| ( nvenc vaapi x264 )"

inherit cmake

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Meumeu/WiVRn.git"
	EGIT_BRANCH="dev"

	MONADO_V=ffb71af26f8349952f5f820c268ee4774613e200
	PFR_V=2.2.0
	SRC_URI="
	https://github.com/boostorg/pfr/archive/refs/tags/${PFR_V}.tar.gz -> boostpfr_${PFR_V}.tar.gz
	https://gitlab.freedesktop.org/monado/monado/-/archive/${MONADO_V}/monado-${MONADO_V}.tar.gz"
else
	SRC_URI="
		https://github.com/Meumeu/WiVRn/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/Meumeu/WiVRn/releases/download/v${PV}/server-build-deps.tar.xz -> ${P}-server-build-deps.tar.xz"
	KEYWORDS="~amd64"
fi

RDEPEND="
	nvenc? (
		x11-drivers/nvidia-drivers
	)
	vaapi? (
		media-video/ffmpeg[libdrm,vaapi]
	)
	x264? (
		media-libs/x264
	)
	dev-libs/libbsd
	media-libs/libpulse
	media-libs/openxr-loader
	net-dns/avahi
	systemd? (
		sys-apps/systemd
	)
	wireshark-plugins? (
		net-analyzer/wireshark
	)
"

BDEPEND="
	${RDEPEND}
	nvenc? (
		dev-util/nvidia-cuda-toolkit
	)
	dev-cpp/eigen
	dev-cpp/nlohmann_json
	dev-util/glslang
"

if [[ ${PV} == 9999 ]]; then
	src_unpack() {
		git-r3_src_unpack
		default_src_unpack
		cd "${WORKDIR}"
		mv "monado-${MONADO_V}" "monado-src"
		mv "pfr-${PFR_V}" "boostpfr-src"
	}
else
	src_unpack() {
		default_src_unpack
		cd "${WORKDIR}"
		mv "WiVRn-${PV}" "${P}"
	}
fi

src_configure() {
	if [[ ${PV} == 9999 ]]; then
		GIT_DESC=$(git describe)
	else
		GIT_DESC=${PV}
	fi
	local mycmakeargs=(
		-DGIT_DESC=${GIT_DESC}
		-DWIVRN_BUILD_CLIENT=OFF
		-DWIVRN_BUILD_SERVER=ON
		-DWIVRN_BUILD_DISSECTOR=$(usex wireshark-plugins)
		-DWIVRN_USE_NVENC=$(usex nvenc)
		-DWIVRN_USE_VAAPI=$(usex vaapi)
		-DWIVRN_USE_X264=$(usex x264)
		-DWIVRN_USE_SYSTEMD=$(usex systemd)
		-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DFETCHCONTENT_BASE_DIR=${WORKDIR}
		-DENABLE_COLOURED_OUTPUT=OFF
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	dosym /usr/share/openxr/1/openxr_wivrn.json /etc/openxr/1/active_runtime.json
}
