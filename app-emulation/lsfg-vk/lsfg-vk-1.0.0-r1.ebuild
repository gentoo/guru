# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1

CRATES="
	adler2@2.0.1
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anyhow@1.0.98
	autocfg@1.5.0
	bindgen@0.70.1
	bitflags@2.9.1
	bumpalo@3.19.0
	cairo-rs@0.21.0
	cairo-sys-rs@0.21.0
	cc@1.2.30
	cexpr@0.6.0
	cfg-expr@0.20.1
	cfg-if@1.0.1
	chrono@0.4.41
	clang-sys@1.8.1
	core-foundation-sys@0.8.7
	crc32fast@1.5.0
	either@1.15.0
	equivalent@1.0.2
	errno@0.3.13
	field-offset@0.3.6
	flate2@1.1.2
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-macro@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	gdk-pixbuf-sys@0.21.0
	gdk-pixbuf@0.21.0
	gdk4-sys@0.10.0
	gdk4@0.10.0
	gio-sys@0.21.0
	gio@0.21.0
	glib-build-tools@0.21.0
	glib-macros@0.21.0
	glib-sys@0.21.0
	glib@0.21.0
	glob@0.3.2
	gobject-sys@0.21.0
	graphene-rs@0.21.0
	graphene-sys@0.21.0
	gsk4-sys@0.10.0
	gsk4@0.10.0
	gtk4-macros@0.10.0
	gtk4-sys@0.10.0
	gtk4@0.10.0
	hashbrown@0.15.4
	heck@0.5.0
	hex@0.4.3
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.63
	indexmap@2.10.0
	itertools@0.13.0
	js-sys@0.3.77
	libadwaita-sys@0.8.0
	libadwaita@0.8.0
	libc@0.2.174
	libloading@0.8.8
	libproc@0.14.10
	linux-raw-sys@0.4.15
	log@0.4.27
	mach2@0.4.3
	memchr@2.7.5
	memoffset@0.9.1
	minimal-lexical@0.2.1
	miniz_oxide@0.8.9
	nom@7.1.3
	num-traits@0.2.19
	once_cell@1.21.3
	pango-sys@0.21.0
	pango@0.21.0
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	pkg-config@0.3.32
	prettyplease@0.2.36
	proc-macro-crate@3.3.0
	proc-macro2@1.0.95
	proc-maps@0.4.0
	procfs-core@0.17.0
	procfs@0.17.0
	quote@1.0.40
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rustc-hash@1.1.0
	rustc_version@0.4.1
	rustix@0.38.44
	rustversion@1.0.21
	semver@1.0.26
	serde@1.0.219
	serde_derive@1.0.219
	serde_spanned@0.6.9
	serde_spanned@1.0.0
	shlex@1.3.0
	slab@0.4.10
	smallvec@1.15.1
	syn@2.0.104
	system-deps@7.0.5
	target-lexicon@0.13.2
	toml@0.8.23
	toml@0.9.2
	toml_datetime@0.6.11
	toml_datetime@0.7.0
	toml_edit@0.22.27
	toml_parser@1.0.1
	toml_writer@1.0.2
	unicode-ident@1.0.18
	version-compare@0.2.0
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.61.2
	windows-implement@0.60.0
	windows-interface@0.59.1
	windows-link@0.1.3
	windows-result@0.3.4
	windows-strings@0.4.2
	windows-sys@0.59.0
	windows-sys@0.60.2
	windows-targets@0.52.6
	windows-targets@0.53.2
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.0
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.0
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.0
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.0
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.0
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.0
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.0
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.0
	winnow@0.7.12
"

inherit cargo cmake desktop flag-o-matic toolchain-funcs

DESCRIPTION="Lossless Scaling Frame Generation on Linux via DXVK/Vulkan"
HOMEPAGE="https://github.com/PancakeTAS/lsfg-vk"
LICENSE="MIT"
SLOT="0"
IUSE="+gui"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PancakeTAS/lsfg-vk"
	EGIT_SUBMODULES=(
		thirdparty/dxbc
		thirdparty/pe-parse
		thirdparty/volk
	)
else
	KEYWORDS="~amd64 ~arm64"
	HASH_DXBC="78ab59a8aaeb43cd1b0a5e91ba86722433a10b78"
	HASH_VOLK="be3dbd49bf77052665e96b6c7484af855e7e5f67"
	PEPARSE_VERSION="2.1.1"
	SRC_URI="
		https://github.com/PancakeTAS/lsfg-vk/archive/refs/tags/v${PV}.tar.gz -> lsfg-vk-${PV}.tar.gz
		https://github.com/PancakeTAS/dxbc/archive/${HASH_DXBC}.tar.gz -> dxbc-${HASH_DXBC}.tar.gz
		https://github.com/trailofbits/pe-parse/archive/refs/tags/v${PEPARSE_VERSION}.tar.gz
			-> pe-parse-${PEPARSE_VERSION}.tar.gz
		https://github.com/zeux/volk/archive/${HASH_VOLK}.tar.gz -> volk-${HASH_VOLK}.tar.gz
		${CARGO_CRATE_URIS}
	"
fi

BDEPEND="
	dev-util/vulkan-headers
	gui? ( ${RUST_DEPEND} )
"
DEPEND="
	dev-cpp/toml11
	dev-util/glslang
	gui? (
		dev-libs/glib:2
		gui-libs/gtk:4[introspection]
		gui-libs/libadwaita
	)
	|| (
		media-libs/glfw
		media-libs/libsdl2
		media-libs/libsdl3
	)
	media-libs/vulkan-loader
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/lsfg-vk-1.0.0-fix-visibility.patch"
)

src_unpack() {
	if [[ ${PV} != 9999 ]]; then
		use gui || default
	else
		git-r3_src_unpack
	fi

	if use gui; then
		if [[ ${PV} != 9999 ]]; then
			cargo_src_unpack
		else
			oldS="${S}"
			S="${S}/ui"
			cargo_live_src_unpack
			S="${oldS}"
		fi
	fi
}

src_prepare() {
	if [[ ${PV} != 9999 ]]; then
		rmdir thirdparty/* || die
		mv ../dxbc-${HASH_DXBC} thirdparty/dxbc || die
		mv ../pe-parse-${PEPARSE_VERSION} thirdparty/pe-parse || die
		mv ../volk-${HASH_VOLK} thirdparty/volk || die
	fi

	# Static linking pe-parse
	sed -i\
		's/^option(BUILD_SHARED_LIBS "Build Shared Libraries" ON)$/option(BUILD_SHARED_LIBS "Build Shared Libraries" OFF)/'\
		thirdparty/pe-parse/CMakeLists.txt || die

	sed -i\
		's|add_library(${PROJECT_NAME} ${PEPARSERLIB_SOURCEFILES})|add_library(${PROJECT_NAME} STATIC ${PEPARSERLIB_SOURCEFILES})|'\
		thirdparty/pe-parse/pe-parser-library/CMakeLists.txt || die

	# Using system toml11
	sed -i\
		-e '/add_subdirectory(thirdparty\/toml11 EXCLUDE_FROM_ALL)/d' \
		-e '/get_target_property(TOML11_INCLUDE_DIRS toml11 INTERFACE_INCLUDE_DIRECTORIES)/{
N
/target_include_directories(lsfg-vk SYSTEM PRIVATE ${TOML11_INCLUDE_DIRS})/c\
find_package(toml11 REQUIRED)
}'\
		-e '/target_link_libraries(lsfg-vk PRIVATE/{:a;N;/)/!ba;s/\btoml11\b/toml11::toml11/g}'\
		CMakeLists.txt || die

	eapply_user
	cmake_src_prepare
}

src_configure() {
	tc-is-gcc && filter-lto # LTO with gcc causes segfaults at runtime
	cmake_src_configure
	use gui && { pushd ui > /dev/null || die; cargo_src_configure; }
}

src_compile() {
	cmake_src_compile
	use gui && { pushd ui > /dev/null || die; cargo_src_compile; }
}

src_install() {
	insinto "/usr/share/vulkan/implicit_layer.d/"
	doins "${S}/VkLayer_LS_frame_generation.json"
	dolib.so "${WORKDIR}/${P}_build/liblsfg-vk.so"
	if use gui; then
		dobin "${S}/ui/$(cargo_target_dir)/lsfg-vk-ui"
		domenu "${S}/ui/rsc/gay.pancake.lsfg-vk-ui.desktop"
		newicon -s 256 "${S}/ui/rsc/icon.png" "gay.pancake.lsfg-vk-ui.png"
	fi
}
