# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

CMAKE_CLANG_COMMIT="7e577af2e963e3dfcce611942fce305c70583b2a"
CMAKE_VERSION_COMMIT="3bef96bafab04161991c2cd98a1ed51f6362d670"
NHOHMANN_JSON_COMMIT="db78ac1d7716f56fc9f1b030b715f872f93964e4"
MSVC_REDIST_HELPER_COMMIT="aa4665ccf68a382f1c2b115fb6c9668b6a8bd64d"
NVIDIA_MAXINE_AR_SDK_COMMIT="ca10ac3b3984357aab84b3c6319d35c82d49e836"
NVIDIA_MAXINE_VFX_SDK_COMMIT="f63d9d1dbd14c905d56648817f132d3eb9a8690d"
NVIDIA_MAXINE_AFX_SDK_COMMIT="4d4ed8d8aca914f4dbf8570f1626cf4108e19bb4"
OBS_STUDIO_COMMIT="abb80571351438bebd018a45d896b26f95881fbe"

#remove when stable release (make life easy later because of new submodules)
M_PV="0.12.0b366"

DESCRIPTION="OBS® Studio plugin which adds many new effects."
HOMEPAGE="https://github.com/Xaymar/obs-StreamFX"
if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Xaymar/obs-StreamFX.git"
else
	SRC_URI="
			https://github.com/Xaymar/obs-StreamFX/archive/refs/tags/${M_PV}.tar.gz -> ${PN}-${M_PV}.tar.gz
			https://github.com/Xaymar/cmake-clang/archive/${CMAKE_CLANG_COMMIT}.tar.gz \
				-> cmake-clang-${CMAKE_CLANG_COMMIT}.tar.gz
			https://github.com/Xaymar/cmake-version/archive/${CMAKE_VERSION_COMMIT}.tar.gz \
				-> cmake-version-${CMAKE_VERSION_COMMIT}.tar.gz
			https://github.com/nlohmann/json/archive/${NHOHMANN_JSON_COMMIT}.tar.gz \
				-> json-${NHOHMANN_JSON_COMMIT}.tar.gz
			https://github.com/Xaymar/msvc-redist-helper/archive/${MSVC_REDIST_HELPER_COMMIT}.tar.gz \
				-> msvc-redist-helper-${MSVC_REDIST_HELPER_COMMIT}.tar.gz
			https://github.com/NVIDIA/MAXINE-AR-SDK/archive/${NVIDIA_MAXINE_AR_SDK_COMMIT}.tar.gz \
				-> MAXINE-AR-SDK-${NVIDIA_MAXINE_AR_SDK_COMMIT}.tar.gz
			https://github.com/NVIDIA/MAXINE-VFX-SDK/archive/${NVIDIA_MAXINE_VFX_SDK_COMMIT}.tar.gz \
				-> MAXINE-VFX-SDK-${NVIDIA_MAXINE_VFX_SDK_COMMIT}.tar.gz
			https://github.com/NVIDIA/MAXINE-AFX-SDK/archive/${NVIDIA_MAXINE_AFX_SDK_COMMIT}.tar.gz \
				-> MAXINE-AFX-SDK-${NVIDIA_MAXINE_AFX_SDK_COMMIT}.tar.gz
			https://github.com/obsproject/obs-studio/archive/${OBS_STUDIO_COMMIT}.tar.gz \
				-> obs-studio-${OBS_STUDIO_COMMIT}.tar.gz
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"
RDEPEND="
	media-video/obs-studio
"

if [[ ${PV} != 9999 ]]; then
	S="${WORKDIR}/obs-StreamFX-${M_PV}"
fi

src_unpack() {
	default

	if [[ ${PV} != 9999 ]]; then
		rm -d "${S}/cmake/clang"
		mv cmake-clang-${CMAKE_CLANG_COMMIT} "${S}/cmake/clang"

		rm -d "${S}/cmake/version"
		mv cmake-version-${CMAKE_VERSION_COMMIT} "${S}/cmake/version"

		rm -d "${S}/third-party/nlohmann-json"
		mv json-${NHOHMANN_JSON_COMMIT} "${S}/third-party/nlohmann-json"

		rm -d "${S}/third-party/msvc-redist-helper"
		mv msvc-redist-helper-${MSVC_REDIST_HELPER_COMMIT} "${S}/third-party/msvc-redist-helper"

		rm -d "${S}/third-party/nvidia-maxine-ar-sdk"
		mv MAXINE-AR-SDK-${NVIDIA_MAXINE_AR_SDK_COMMIT} "${S}/third-party/nvidia-maxine-ar-sdk"

		rm -d "${S}/third-party/nvidia-maxine-vfx-sdk"
		mv MAXINE-VFX-SDK-${NVIDIA_MAXINE_VFX_SDK_COMMIT} "${S}/third-party/nvidia-maxine-vfx-sdk"

		rm -d "${S}/third-party/nvidia-maxine-afx-sdk"
		mv MAXINE-AFX-SDK-${NVIDIA_MAXINE_AFX_SDK_COMMIT} "${S}/third-party/nvidia-maxine-afx-sdk"

		rm -d "${S}/third-party/obs-studio"
		mv obs-studio-${OBS_STUDIO_COMMIT} "${S}/third-party/obs-studio"

	else
		git-r3_src_unpack
	fi
}

src_prepare() {
	default

	#fix CMakeLists.txt libdir
	sed -i 's|"lib/obs-plugins/"|"${CMAKE_INSTALL_LIBDIR}/obs-plugins/"|g' "${S}/CMakeLists.txt"
	cmake_src_prepare
}

src_configure() {

	local mycmakeargs+=(
		-DSTRUCTURE_PACKAGEMANAGER=TRUE
		-DPACKAGE_NAME="obs-streamfx"
		$([[ ${PV} != "9999" ]] && echo "-DVERSION=${M_PV}")
	)

	cmake_src_configure
}
