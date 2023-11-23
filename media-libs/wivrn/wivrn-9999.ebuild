EAPI=7

DESCRIPTION="WiVRn OpenXR streaming"
HOMEPAGE="https://github.com/meumeu/WiVRn"
SLOT="0"
LICENSE="GPL-3 Apache-2.0 MIT"

IUSE="nvenc vaapi x264"

inherit cmake

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Meumeu/WiVRn.git"

	MONADO_V=3ca1381be18e4cda516a2c7ac5778706aac89ce4
	PFR_V=2.0.3
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
		media-video/ffmpeg[vulkan,vaapi]
	)
	x264? (
		media-libs/x264
	)
	dev-libs/libbsd
	media-libs/openxr-loader
	net-dns/avahi
	sys-apps/systemd
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
		-DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON
		-DFETCHCONTENT_FULLY_DISCONNECTED=ON
		-DFETCHCONTENT_BASE_DIR=${WORKDIR}
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	dosym /usr/share/openxr/1/openxr_wivrn.json /etc/openxr/1/active_runtime.json
}
