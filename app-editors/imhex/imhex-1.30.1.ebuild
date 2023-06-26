# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_BUILD_TYPE="Release"
CMAKE_MAKEFILE_GENERATOR="emake"

inherit cmake llvm toolchain-funcs

DESCRIPTION="A hex editor for reverse engineers, programmers, and eyesight"
HOMEPAGE="https://github.com/WerWolv/ImHex"
SRC_URI="
	https://github.com/WerWolv/ImHex/releases/download/v${PV}/Full.Sources.tar.gz -> ${P}.tar.gz
	https://github.com/WerWolv/ImHex-Patterns/archive/refs/tags/ImHex-v${PV}.tar.gz -> ${PN}-patterns-${PV}.tar.gz
"
S="${WORKDIR}/ImHex"
S_PATTERNS="${WORKDIR}/ImHex-Patterns-ImHex-v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-forensics/yara
	>=dev-cpp/nlohmann_json-3.10.2
	dev-libs/capstone
	dev-libs/nativefiledialog-extended
	>=dev-libs/libfmt-8.0.0:=
	media-libs/freetype
	media-libs/glfw
	media-libs/glm
	net-libs/libssh2
	net-libs/mbedtls
	net-misc/curl
	sys-apps/dbus
	sys-apps/file
	sys-apps/xdg-desktop-portal
	virtual/libiconv
	virtual/libintl
"
RDEPEND="${DEPEND}"
BDEPEND="
	app-admin/chrpath
	gnome-base/librsvg
	sys-devel/lld
	dev-util/ccache
"

pkg_pretend() {
	if tc-is-gcc && [[ $(gcc-major-version) -lt 12 ]]; then
		die "${PN} requires GCC 12 or newer"
	fi
}

src_prepare() {
	default
	# We are removing all tests altogether
	# The tests need ImHex installed to succeed (see https://bugs.gentoo.org/attachment.cgi?id=860683), so we remove them
	# We could use `ln "${BUILD_DIR}/lib/libimhex.so.${PV}" "/lib64/libimhex.so.${PV}"` and  circumvent sandboxing
	sed -i \
		-e 's/enable_testing/#enable_testing/' \
		-e 's/add_subdirectory(tests/#add_subdirectory(tests/' \
		"${S}/CMakeLists.txt" || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-D CMAKE_BUILD_TYPE="Release" \
		-D CMAKE_C_COMPILER_LAUNCHER=ccache \
		-D CMAKE_CXX_COMPILER_LAUNCHER=ccache \
		-D CMAKE_C_FLAGS="-fuse-ld=lld ${CFLAGS}" \
		-D CMAKE_CXX_FLAGS="-fuse-ld=lld ${CXXFLAGS}" \
		-D CMAKE_OBJC_COMPILER_LAUNCHER=ccache \
		-D CMAKE_OBJCXX_COMPILER_LAUNCHER=ccache \
		-D CMAKE_SKIP_RPATH=ON \
		-D IMHEX_USE_BUNDLED_CA=OFF \
		-D IMHEX_PLUGINS_IN_SHARE=OFF \
		-D IMHEX_STRIP_RELEASE=OFF \
		-D IMHEX_OFFLINE_BUILD=ON \
		-D IMHEX_IGNORE_BAD_CLONE=ON \
		-D IMHEX_PATTERNS_PULL_MASTER=OFF \
		-D IMHEX_IGNORE_BAD_COMPILER=OFF \
		-D IMHEX_USE_GTK_FILE_PICKER=OFF \
		-D IMHEX_DISABLE_STACKTRACE=OFF \
		-D IMHEX_VERSION="${PV}" \
		-D PROJECT_VERSION="${PV}" \
		-D USE_SYSTEM_CAPSTONE=ON \
		-D USE_SYSTEM_CURL=ON \
		-D USE_SYSTEM_FMT=ON \
		-D USE_SYSTEM_LLVM=ON \
		-D USE_SYSTEM_NFD=ON \
		-D USE_SYSTEM_NLOHMANN_JSON=ON \
		-D USE_SYSTEM_YARA=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	# Install patterns
	insinto /usr/share/imhex
	rm -rf "${S_PATTERNS}/tests"
	doins -r "${S_PATTERNS}"/*
}
