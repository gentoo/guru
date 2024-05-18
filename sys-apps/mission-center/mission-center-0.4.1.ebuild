# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler32@1.2.0
	adler@1.0.2
	ahash@0.3.8
	ahash@0.8.6
	aho-corasick@1.1.2
	allocator-api2@0.2.16
	anyhow@1.0.75
	arrayvec@0.5.2
	arrayvec@0.7.4
	ash@0.37.3+1.3.251
	async-channel@1.9.0
	async-lock@2.8.0
	async-task@4.5.0
	atomic-waker@1.1.2
	autocfg@1.1.0
	base64@0.21.5
	bitflags@1.3.2
	bitflags@2.4.1
	block-buffer@0.10.4
	block@0.1.6
	blocking@1.4.1
	bumpalo@3.14.0
	byte-slice-cast@0.3.5
	bytemuck@1.14.0
	bytemuck_derive@1.5.0
	byteorder@1.5.0
	cairo-rs@0.18.3
	cairo-sys-rs@0.18.2
	cargo-util@0.2.6
	cc@1.0.83
	cfg-expr@0.15.5
	cfg-if@0.1.10
	cfg-if@1.0.0
	color_quant@1.1.0
	concurrent-queue@2.3.0
	const-random-macro@0.1.16
	const-random@0.1.17
	core-foundation-sys@0.8.4
	core-foundation@0.9.3
	cpufeatures@0.2.11
	crc32fast@1.3.2
	crossbeam-channel@0.4.4
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-utils@0.7.2
	crossbeam-utils@0.8.16
	crunchy@0.2.2
	crypto-common@0.1.6
	dbus-crossroads@0.5.2
	dbus@0.9.7
	deflate@0.8.6
	digest@0.10.7
	dlv-list@0.5.2
	drm-ffi@0.7.0
	drm-fourcc@2.2.0
	drm-sys@0.6.0
	drm@0.11.0
	egl@0.2.7
	either@1.9.0
	equivalent@1.0.1
	errno-sys@0.2.0
	errno@0.3.6
	event-listener@2.5.3
	fallible-iterator@0.3.0
	fallible-streaming-iterator@0.1.9
	fastrand@2.0.1
	field-offset@0.3.6
	filetime@0.2.22
	flate2@1.0.28
	form_urlencoded@1.2.0
	futures-channel@0.3.29
	futures-core@0.3.29
	futures-executor@0.3.29
	futures-io@0.3.29
	futures-lite@1.13.0
	futures-macro@0.3.29
	futures-task@0.3.29
	futures-util@0.3.29
	fxhash@0.2.1
	gbm-sys@0.3.0
	gbm@0.14.0
	gdk-pixbuf-sys@0.18.0
	gdk-pixbuf@0.18.3
	gdk4-sys@0.7.2
	gdk4@0.7.3
	generic-array@0.14.7
	getrandom@0.2.11
	gettext-rs@0.7.0
	gettext-sys@0.21.3
	gio-sys@0.18.1
	gio@0.18.3
	gl@0.14.0
	gl_generator@0.14.0
	gl_loader@0.1.2
	glib-macros@0.18.3
	glib-sys@0.18.1
	glib@0.18.3
	gobject-sys@0.18.0
	graphene-rs@0.18.1
	graphene-sys@0.18.1
	gsk4-sys@0.7.3
	gsk4@0.7.3
	gtk4-macros@0.7.2
	gtk4-sys@0.7.3
	gtk4@0.7.3
	half@1.8.2
	hashbrown@0.14.2
	hashbrown@0.14.3
	hashbrown@0.7.2
	hashlink@0.8.4
	heck@0.4.1
	hermit-abi@0.3.3
	hex@0.4.3
	idna@0.4.0
	image@0.23.14
	indexmap@2.1.0
	instant@0.1.12
	interprocess@1.2.1
	intmap@0.7.1
	itoa@1.0.9
	jobserver@0.1.27
	js-sys@0.3.65
	khronos@0.1.2
	khronos_api@3.1.0
	lazy_static@1.4.0
	libadwaita-sys@0.5.3
	libadwaita@0.5.3
	libc@0.1.12
	libc@0.2.150
	libdbus-sys@0.2.5
	libloading@0.7.4
	libsqlite3-sys@0.27.0
	libudev-sys@0.1.4
	linux-raw-sys@0.4.11
	linux-raw-sys@0.6.1
	locale_config@0.3.0
	lock_api@0.4.11
	log@0.4.20
	malloc_buf@0.0.6
	maybe-uninit@2.0.0
	memchr@2.6.4
	memoffset@0.9.0
	miniz_oxide@0.3.7
	miniz_oxide@0.7.1
	miow@0.6.0
	nix@0.26.4
	ntapi@0.4.1
	num-integer@0.1.45
	num-iter@0.1.43
	num-rational@0.3.2
	num-traits@0.2.17
	num_cpus@1.16.0
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	once_cell@1.18.0
	ordered-multimap@0.7.1
	pango-sys@0.18.0
	pango@0.18.3
	percent-encoding@2.3.0
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	piper@0.2.1
	pkg-config@0.3.27
	png@0.16.8
	ppv-lite86@0.2.17
	proc-macro-crate@1.3.1
	proc-macro-crate@2.0.0
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@1.0.69
	quote@1.0.33
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	raw-cpuid@11.0.1
	rayon-core@1.12.0
	rayon@1.8.0
	redox_syscall@0.3.5
	redox_syscall@0.4.1
	regex-automata@0.4.3
	regex-syntax@0.8.2
	regex@1.10.2
	ring@0.17.5
	rusqlite@0.30.0
	rust-ini@0.20.0
	rustc_version@0.4.0
	rustix@0.38.25
	rustls-webpki@0.101.7
	rustls@0.21.8
	ryu@1.0.15
	same-file@1.0.6
	scopeguard@1.2.0
	sct@0.7.1
	semver@1.0.20
	serde@1.0.192
	serde_derive@1.0.192
	serde_json@1.0.108
	serde_spanned@0.6.4
	sha2@0.10.8
	shared_memory_extended@0.13.0
	shell-escape@0.1.5
	slab@0.4.9
	smallvec@1.11.2
	spin@0.9.8
	spinning@0.1.0
	syn@1.0.109
	syn@2.0.39
	sysinfo@0.29.10
	system-deps@6.2.0
	tar@0.4.40
	target-lexicon@0.12.12
	temp-dir@0.1.11
	tempfile@3.8.1
	textdistance@1.0.2
	thiserror-impl@1.0.50
	thiserror@1.0.50
	tiny-keccak@2.0.2
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	to_method@1.1.0
	toml@0.8.8
	toml_datetime@0.6.5
	toml_edit@0.19.15
	toml_edit@0.20.7
	toml_edit@0.21.0
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	typenum@1.17.0
	unicode-bidi@0.3.13
	unicode-ident@1.0.12
	unicode-normalization@0.1.22
	untrusted@0.9.0
	ureq@2.8.0
	url@2.4.1
	vcpkg@0.2.15
	vec_map@0.8.2
	version-compare@0.1.1
	version_check@0.9.4
	walkdir@2.4.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.88
	wasm-bindgen-macro-support@0.2.88
	wasm-bindgen-macro@0.2.88
	wasm-bindgen-shared@0.2.88
	wasm-bindgen@0.2.88
	web-sys@0.3.65
	webpki-roots@0.25.2
	win-sys@0.3.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows@0.34.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.34.0
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.34.0
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.34.0
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.34.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.34.0
	windows_x86_64_msvc@0.48.5
	winnow@0.5.19
	xattr@1.0.1
	xml-rs@0.8.19
	zerocopy-derive@0.7.25
	zerocopy@0.7.25
"

PYTHON_COMPAT=( python3_{9..12} )

PATHFINDER_COMMIT=ec56924f660e6faa83c81c6b62b3c69b9a9fa00e
NVTOP_COMMIT=45a1796375cd617d16167869bb88e5e69c809468

declare -A GIT_CRATES=(
	[pathfinder_canvas]="https://github.com/kicsyromy/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/canvas/"
	[pathfinder_content]="https://github.com/kicsyromy/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/content/"
	[pathfinder_color]="https://github.com/kicsyromy/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/color/"
	[pathfinder_geometry]="https://github.com/kicsyromy/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/geometry/"
	[pathfinder_gl]="https://github.com/kicsyromy/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/gl/"
	[pathfinder_gpu]="https://github.com/kicsyromy/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/gpu/"
	[pathfinder_renderer]="https://github.com/kicsyromy/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/renderer/"
	[pathfinder_resources]="https://github.com/kicsyromy/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/resources/"
)

inherit cargo gnome2-utils meson python-any-r1 xdg

DESCRIPTION="Monitor your CPU, Memory, Disk, Network and GPU usage."
HOMEPAGE="https://missioncenter.io/"

SRC_URI="
	https://gitlab.com/mission-center-devs/mission-center/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2
	https://github.com/Syllo/nvtop/archive/${NVTOP_COMMIT}.tar.gz -> nvtop-${NVTOP_COMMIT}.tar.gz
	${CARGO_CRATE_URIS}

"
S="${WORKDIR}/${PN}-v${PV}"
BUILD_DIR="${S}-build"
ECARGO_HOME="${S}-build/cargo-home"
LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 Boost-1.0 CC0-1.0 CeCILL-2 MIT Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="
	>=dev-libs/appstream-0.16.4
	>=x11-libs/pango-1.51.0
	>=dev-libs/glib-2.77
	>=dev-util/gdbus-codegen-2.77
	dev-libs/wayland
	>=gui-libs/libadwaita-1.4.0
	>=gui-libs/gtk-4.12.3
	gui-libs/egl-gbm
	virtual/rust
	virtual/udev
	x11-libs/libdrm
"
RDEPEND="
	${DEPEND}
	sys-apps/dmidecode
"
BDEPEND="
	${PYTHON_DEPS}
	dev-libs/gobject-introspection
	>=dev-build/meson-0.63
	dev-util/blueprint-compiler
"

src_unpack() {
	unpack ${P}.tar.bz2
	unpack nvtop-${NVTOP_COMMIT}.tar.gz
	GATHERER_BUILD_DIR=$(usex debug debug release)
	mkdir -p "${BUILD_DIR}/src/sys_info_v2/gatherer/src/${GATHERER_BUILD_DIR}/build/native" || die
	mv nvtop-${NVTOP_COMMIT} "${BUILD_DIR}/src/sys_info_v2/gatherer/src/${GATHERER_BUILD_DIR}/build/native" || die
	cargo_src_unpack
}

src_prepare() {
	eapply_user
	GATHERER_BUILD_DIR=$(usex debug debug release)
	cd "${BUILD_DIR}/src/sys_info_v2/gatherer/src/${GATHERER_BUILD_DIR}/build/native/nvtop-${NVTOP_COMMIT}" || die
	find "${S}/src/sys_info_v2/gatherer/3rdparty/nvtop/patches" -type f -name 'nvtop-*' -exec sh -c 'patch -p1 < {}' \; || die
}

src_configure() {
	local emesonargs=(
		--buildtype $(usex debug debug release)
		--prefix=/usr
	)
	meson_src_configure
	cp -r "${ECARGO_HOME}" "${BUILD_DIR}/src/sys_info_v2/gatherer/cargo-home" || die
}

src_test() {
	# patch the appstream-util validate command to use --nonet when validating the urls
	sed -i "s/args: \['validate',/args: \['validate', '--nonet',/g" "${S}/data/meson.build" || die
	meson_src_test
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="
	usr/bin/missioncenter
	usr/bin/missioncenter-gatherer
"
