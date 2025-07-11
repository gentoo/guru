# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

CHKSUM="cb117806d14ab2c31db86d5b8cab5c58b791dd6c"

DESCRIPTION="C++/WASM GL Framework"
HOMEPAGE="https://github.com/patriciogonzalezvivo/vera"
SRC_URI="https://github.com/patriciogonzalezvivo/vera/archive/${CHKSUM}.tar.gz -> ${PN}-${CHKSUM}.tar.gz"
S="${WORKDIR}/${PN}-${CHKSUM}"

LICENSE="Prosperity-3.0.0"
SLOT="0"
IUSE="X wayland"

DEPEND="
	dev-cpp/nlohmann_json
	media-libs/glm
	dev-libs/miniz
	dev-cpp/tinygltf
	dev-libs/stb
	dev-libs/miniaudio
	media-video/ffmpeg
	media-libs/libsdl2
	dev-libs/glib
	media-libs/libpulse
	virtual/opengl
	virtual/glu

	media-libs/glfw

	X? (
		x11-libs/libX11
		x11-libs/libXrandr
		x11-libs/libXcursor
		x11-libs/libXi
		x11-libs/libXxf86vm
	)

	wayland? (
		dev-libs/wayland
		gui-libs/libdecor
		x11-libs/libxkbcommon
	)
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/0001-Bump-cmake-min-version.patch"
	"${FILESDIR}/0002-Remove-hardcoded-installation-dir.patch"
	"${FILESDIR}/0003-Use-dev-libs-stb-package.patch"
	"${FILESDIR}/0004-Change-include-lines.patch"
	"${FILESDIR}/0005-Remove-some-bundled-deps.patch"
	"${FILESDIR}/0006-Fix-in-class-initialization.patch"
)

src_prepare() {
	cmake_src_prepare
	local libdir=$(get_libdir)
	rm -rf "${S}/deps"{glew,glfw,glm,miniaudio,miniz,stb,tinygltf} || die "delete bundled deps failed"
	sed \
		-e "s|@LIBDIR@|${libdir%/}/|g" \
		-e "s|@VERSION@|${PV}|g" \
		"${FILESDIR}/vera.pc.in" > vera.pc || die "sed failed"
}

src_configure() {
	local libdir=$(get_libdir)
	local args=(
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCMAKE_INSTALL_LIBDIR=${libdir}
		-DNO_X11="$(usex X OFF ON)"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	insinto /usr/$(get_libdir)/pkgconfig
	doins vera.pc
}
