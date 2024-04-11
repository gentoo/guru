# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake llvm toolchain-funcs desktop

DESCRIPTION="A hex editor for reverse engineers, programmers, and eyesight"
HOMEPAGE="https://github.com/WerWolv/ImHex"
SRC_URI="
	https://github.com/WerWolv/ImHex/releases/download/v${PV}/Full.Sources.tar.gz -> ${P}.gh.tar.gz
	https://github.com/WerWolv/ImHex-Patterns/archive/refs/tags/ImHex-v${PV}.tar.gz -> ${PN}-patterns-${PV}.gh.tar.gz
"
S="${WORKDIR}/ImHex"
S_PATTERNS="${WORKDIR}/ImHex-Patterns-ImHex-v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+system-llvm test lto"
RESTRICT="!test? ( test )"

PATCHES=(
	# If virtual/dotnet-sdk is installed on your system, then cmake
	# will use it at some point and try to access internet.
	# Because it did not cause any issue, we can disable it
	"${FILESDIR}/remove_dotnet.patch"
)

DEPEND="
	app-arch/bzip2
	app-arch/xz-utils
	app-arch/zstd:=
	app-forensics/yara:=
	>=dev-cpp/nlohmann_json-3.10.2
	dev-libs/capstone:=
	dev-libs/nativefiledialog-extended:=
	>=dev-libs/libfmt-8.0.0:=
	media-libs/freetype
	media-libs/glfw
	media-libs/glm
	media-libs/libglvnd
	net-libs/mbedtls:=
	net-misc/curl
	sys-apps/file
	sys-apps/xdg-desktop-portal
	sys-libs/zlib
	virtual/libiconv
	virtual/libintl
"
RDEPEND="${DEPEND}"
BDEPEND="
	system-llvm? ( sys-devel/llvm )
	app-admin/chrpath
	gnome-base/librsvg
"

pkg_pretend() {
	if tc-is-gcc && [[ $(gcc-major-version) -lt 12 ]]; then
		die "${PN} requires GCC 12 or newer"
	fi
}

src_configure() {
	if use test; then
		sed -ie "s/tests EXCLUDE_FROM_ALL/tests ALL/" "${S}/CMakeLists.txt"
	fi

	local mycmakeargs=(
		-D IMHEX_PLUGINS_IN_SHARE=OFF \
		-D IMHEX_STRIP_RELEASE=OFF \
		-D IMHEX_OFFLINE_BUILD=ON \
		-D IMHEX_IGNORE_BAD_CLONE=ON \
		-D IMHEX_PATTERNS_PULL_MASTER=OFF \
		-D IMHEX_IGNORE_BAD_COMPILER=OFF \
		-D IMHEX_USE_GTK_FILE_PICKER=OFF \
		-D IMHEX_DISABLE_STACKTRACE=ON \
		-D IMHEX_BUNDLE_DOTNET=OFF \
		-D IMHEX_ENABLE_LTO=$(usex lto) \
		-D IMHEX_USE_DEFAULT_BUILD_SETTINGS=OFF \
		-D IMHEX_STRICT_WARNINGS=OFF \
		-D IMHEX_ENABLE_UNIT_TESTS=$(usex test) \
		-D IMHEX_ENABLE_PRECOMPILED_HEADERS=OFF \
		-D IMHEX_VERSION="${PV}" \
		-D PROJECT_VERSION="${PV}" \
		-D USE_SYSTEM_CAPSTONE=ON \
		-D USE_SYSTEM_FMT=ON \
		-D USE_SYSTEM_LLVM=$(usex system-llvm) \
		-D USE_SYSTEM_NFD=ON \
		-D USE_SYSTEM_NLOHMANN_JSON=ON \
		-D USE_SYSTEM_YARA=ON
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	domenu "${S}/dist/${PN}.desktop"

	# Install patterns
	insinto /usr/share/imhex
	rm -rf "${S_PATTERNS}/tests"
	doins -r "${S_PATTERNS}"/*
}
