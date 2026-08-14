# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	anstyle@1.0.14
	bitflags@2.11.0
	calloop@0.14.4
	cc@1.2.59
	cfg-if@1.0.4
	cfg_aliases@0.2.1
	clap@4.6.0
	clap_builder@4.6.0
	clap_lex@1.1.0
	codespan-reporting@0.13.1
	concurrent-queue@2.5.0
	crossbeam-utils@0.8.21
	cxx-build@1.0.194
	cxx@1.0.194
	cxxbridge-cmd@1.0.194
	cxxbridge-flags@1.0.194
	cxxbridge-macro@1.0.194
	downcast-rs@1.2.1
	equivalent@1.0.2
	errno@0.3.14
	find-msvc-tools@0.1.9
	foldhash@0.2.0
	hashbrown@0.16.1
	hermit-abi@0.3.9
	hermit-abi@0.5.2
	indexmap@2.13.1
	input-sys@1.19.0
	input@0.10.0
	io-lifetimes@1.0.11
	libc@0.2.184
	libudev-sys@0.1.4
	link-cplusplus@1.0.12
	linux-raw-sys@0.12.1
	log@0.4.29
	memchr@2.8.0
	nix@0.31.2
	pin-project-lite@0.2.17
	pkg-config@0.3.32
	polling@3.11.0
	prettyplease@0.2.37
	proc-macro2@1.0.106
	quick-xml@0.39.2
	quote@1.0.45
	rustix@1.1.4
	scratch@1.0.9
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	shlex@1.3.0
	slab@0.4.12
	smallvec@1.15.1
	strsim@0.11.1
	syn@2.0.117
	termcolor@1.4.1
	tracing-core@0.1.36
	tracing@0.1.44
	udev@0.9.3
	unicode-ident@1.0.24
	unicode-width@0.2.2
	wayland-backend@0.3.15
	wayland-scanner@0.31.10
	wayland-server@0.31.13
	wayland-sys@0.31.11
	winapi-util@0.1.11
	windows-link@0.2.1
	windows-sys@0.48.0
	windows-sys@0.61.2
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
"

RUST_MIN_VER="1.85.0"

inherit cargo cmake xdg

DESCRIPTION="Set of libraries for building Wayland based shells"
HOMEPAGE="https://canonical.com/mir"
SRC_URI="
	https://github.com/canonical/mir/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="|| ( GPL-2 GPL-3 ) || ( LGPL-2.1 LGPL-3 )"
# Dependent crate licenses
LICENSE+=" Apache-2.0 MIT Unicode-3.0 ZLIB"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64"
IUSE="examples test wayland X"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/glibmm:2
	dev-cpp/libxmlpp:2.6
	dev-cpp/yaml-cpp:=
	dev-libs/boost:=
	dev-libs/glib:2
	dev-libs/libinput:=
	dev-libs/wayland
	dev-util/lttng-ust:=
	media-libs/freetype
	media-libs/libdisplay-info:=
	media-libs/libepoxy
	media-libs/libglvnd
	media-libs/mesa
	sys-apps/util-linux
	x11-libs/libXcursor
	x11-libs/libdrm
	x11-libs/libxcb:=
	x11-libs/libxkbcommon
	x11-libs/pixman
	virtual/libudev:=
	X? ( x11-libs/libX11 )
"
DEPEND="
	${RDEPEND}
	media-libs/glm
"
BDEPEND="
	dev-util/gdbus-codegen
	virtual/pkgconfig
	test? (
		dev-cpp/gtest
		dev-util/umockdev
		x11-base/xwayland
	)
"

PATCHES=(
	# bug 932786
	"${FILESDIR}/${PN}-2.17.0-remove-debug-flags.patch"
	"${FILESDIR}/${PN}-2.28.0-remove-tests.patch"
)

src_prepare() {
	cmake_src_prepare
	use examples || cmake_comment_add_subdirectory examples/ examples/tests/
}

src_configure() {
	local platforms=( gbm-kms atomic-kms )
	use wayland && platforms+=( wayland )
	use X && platforms+=( x11 )

	local mycmakeargs=(
		# wlcs is not packaged
		-DMIR_ENABLE_WLCS_TESTS=OFF
		-DMIR_ENABLE_TESTS="$(usex test)"
		-DMIR_FATAL_COMPILE_WARNINGS=OFF
		-DMIR_PLATFORM="$(IFS=';'; echo "${platforms[*]}")"
		-DMIR_ENABLE_RUST=ON
	)
	use test && mycmakeargs+=(
		# likely will not work in build environment
		-DMIR_BUILD_PERFORMANCE_TESTS=OFF
		-DMIR_BUILD_PLATFORM_TEST_HARNESS=OFF
		-DMIR_BUILD_UNIT_TESTS=OFF
	)
	cmake_src_configure
}

src_test() {
	xdg_environment_reset
	cmake_src_test
}
