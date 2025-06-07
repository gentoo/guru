# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake desktop flag-o-matic

MY_PV="${PV%.*}-${PV##*.}"

DESCRIPTION="Fast Sony PlayStation (PSX) emulator"
HOMEPAGE="https://github.com/stenzek/duckstation"
SRC_URI="https://github.com/stenzek/duckstation/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="CC-BY-NC-ND-4.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+clang cpu_flags_x86_sse2 cpu_flags_x86_sse4_1 -mini opengl +qt6 vulkan wayland X"

RESTRICT=bindist

# Either or both frontends must be built
REQUIRED_USE="
	|| ( opengl vulkan )
	opengl? (
		|| ( wayland X )
	)
	qt6? (
		|| ( wayland X )
	)
	!qt6? ( mini )
	x86? (
		|| ( cpu_flags_x86_sse2 cpu_flags_x86_sse4_1 )
	)
"

BDEPEND="
	clang? ( llvm-core/clang:* )
	dev-libs/cpuinfo
	virtual/pkgconfig
	wayland? ( kde-frameworks/extra-cmake-modules )
"
DEPEND="
	dev-cpp/rapidyaml
	dev-libs/libbacktrace
	dev-libs/libfmt
	dev-libs/xxhash
	dev-util/spirv-cross
	net-misc/curl[ssl]
	sys-apps/dbus
	media-libs/libsoundtouch
	media-libs/sdl3-ttf[plutosvg]
	opengl? ( virtual/opengl )
	qt6? (
		dev-qt/qtbase:6[gui,network,widgets]
		dev-qt/qttools:6[linguist]
	)
	vulkan? (
		dev-util/vulkan-headers
		dev-util/vulkan-memory-allocator
	)
	wayland? ( dev-qt/qtwayland:6 )
	X? (
		x11-libs/libX11
		x11-libs/libXrandr
	)
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/disable-discord.patch
	"${FILESDIR}"/vanilla-shaderc.patch
	"${FILESDIR}"/cmake-dependencies.patch
	"${FILESDIR}"/duckstation-mini.patch
	"${FILESDIR}"/duckstation-qt.patch
	"${FILESDIR}"/missing-headers.patch
	"${FILESDIR}"/soundtouch-path.patch
	"${FILESDIR}"/gcc-compatibility.patch
)

src_prepare() {
	# Disable auto-update and unoffical build prompt
	touch "${S}"/src/scmversion/tag.h

	eapply_user
	cmake_src_prepare
}

src_configure() {
	if use clang; then
		local -x CC=${CHOST}-clang
		local -x CXX=${CHOST}-clang++
		strip-unsupported-flags
	else
		append-cxxflags -fpermissive
	fi

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=no
		-DBUILD_MINI_FRONTEND=$(usex mini)
		-DBUILD_QT_FRONTEND=$(usex qt6)
		-DENABLE_OPENGL=$(usex opengl)
		-DENABLE_VULKAN=$(usex vulkan)
		-DENABLE_WAYLAND=$(usex wayland)
		-DENABLE_X11=$(usex X)
		-DDISABLE_SSE4=$(usex cpu_flags_x86_sse4_1 "no" "yes")
	)
	cmake_src_configure
}

src_install() {
	dodoc README.md

	insinto /usr/share/${PN}
	doins -r "${BUILD_DIR}"/bin/resources

	if use mini; then
		newicon "${S}"/data/resources/images/duck.png duckstation-nogui.png
		make_desktop_entry "${PN}-mini %f" "DuckStation Mini" "${PN}-mini" "Game"

		dobin "${BUILD_DIR}"/bin/duckstation-mini
	fi

	if use qt6; then
		newicon "${BUILD_DIR}"/bin/resources/images/duck.png duckstation-qt.png
		make_desktop_entry "${PN}-qt %f" "DuckStation Qt" "${PN}-qt" "Game"

		doins -r "${BUILD_DIR}"/bin/translations/
		dobin "${BUILD_DIR}"/bin/duckstation-qt
	fi
}
