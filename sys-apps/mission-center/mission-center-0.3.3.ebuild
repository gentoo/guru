# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler32@1.2.0
	adler@1.0.2
	ahash@0.3.8
	ahash@0.8.3
	aho-corasick@1.0.2
	allocator-api2@0.2.15
	anyhow@1.0.71
	anyhow@1.0.72
	arrayvec@0.5.2
	arrayvec@0.7.4
	async-channel@1.9.0
	async-lock@2.7.0
	async-task@4.4.0
	atomic-waker@1.1.1
	autocfg@1.1.0
	base64@0.21.4
	bitflags@1.3.2
	bitflags@2.3.3
	bitflags@2.4.0
	block-buffer@0.10.4
	block@0.1.6
	blocking@1.3.1
	bumpalo@3.13.0
	byte-slice-cast@0.3.5
	bytemuck@1.13.1
	bytemuck@1.14.0
	bytemuck_derive@1.5.0
	byteorder@1.4.3
	cairo-rs@0.18.0
	cairo-sys-rs@0.18.0
	cargo-util@0.2.5
	cc@1.0.79
	cc@1.0.83
	cfg-expr@0.15.3
	cfg-if@0.1.10
	cfg-if@1.0.0
	color_quant@1.1.0
	concurrent-queue@2.2.0
	const-random-macro@0.1.15
	const-random@0.1.15
	core-foundation-sys@0.8.4
	core-foundation@0.9.3
	cpufeatures@0.2.9
	crc32fast@1.3.2
	crossbeam-channel@0.4.4
	crossbeam-channel@0.5.8
	crossbeam-deque@0.8.3
	crossbeam-epoch@0.9.15
	crossbeam-utils@0.7.2
	crossbeam-utils@0.8.16
	crunchy@0.2.2
	crypto-common@0.1.6
	deflate@0.8.6
	digest@0.10.7
	dlv-list@0.5.0
	drm-ffi@0.5.0
	drm-fourcc@2.2.0
	drm-sys@0.4.0
	drm@0.9.0
	egl@0.2.7
	either@1.8.1
	equivalent@1.0.0
	errno-dragonfly@0.1.2
	errno-sys@0.1.0
	errno@0.3.3
	event-listener@2.5.3
	fallible-iterator@0.2.0
	fallible-streaming-iterator@0.1.9
	fastrand@1.9.0
	fastrand@2.0.0
	field-offset@0.3.6
	filetime@0.2.22
	flate2@1.0.27
	form_urlencoded@1.2.0
	futures-channel@0.3.28
	futures-core@0.3.28
	futures-executor@0.3.28
	futures-io@0.3.28
	futures-lite@1.13.0
	futures-macro@0.3.28
	futures-task@0.3.28
	futures-util@0.3.28
	fxhash@0.2.1
	gbm-sys@0.2.2
	gbm@0.12.0
	gdk-pixbuf-sys@0.18.0
	gdk-pixbuf@0.18.0
	gdk4-sys@0.7.2
	gdk4@0.7.2
	generic-array@0.14.7
	getrandom@0.2.10
	gettext-rs@0.7.0
	gettext-sys@0.21.3
	gio-sys@0.18.1
	gio@0.18.1
	gl@0.14.0
	gl_generator@0.14.0
	glib-macros@0.18.0
	glib-sys@0.18.1
	glib@0.18.1
	gobject-sys@0.18.0
	graphene-rs@0.18.1
	graphene-sys@0.18.1
	gsk4-sys@0.7.2
	gsk4@0.7.2
	gtk4-macros@0.7.2
	gtk4-sys@0.7.2
	gtk4@0.7.2
	half@1.8.2
	hashbrown@0.13.2
	hashbrown@0.14.0
	hashbrown@0.7.2
	hashlink@0.8.3
	heck@0.4.1
	hermit-abi@0.3.2
	hex@0.4.3
	idna@0.4.0
	image@0.23.14
	indexmap@2.0.0
	instant@0.1.12
	interprocess@1.2.1
	intmap@0.7.1
	itoa@1.0.8
	itoa@1.0.9
	jobserver@0.1.26
	js-sys@0.3.64
	khronos@0.1.2
	khronos_api@3.1.0
	lazy_static@1.4.0
	libadwaita-sys@0.5.2
	libadwaita@0.5.2
	libc@0.1.12
	libc@0.2.147
	libsqlite3-sys@0.26.0
	libudev-sys@0.1.4
	linux-raw-sys@0.4.7
	locale_config@0.3.0
	lock_api@0.4.10
	log@0.4.19
	malloc_buf@0.0.6
	maybe-uninit@2.0.0
	memchr@2.5.0
	memoffset@0.7.1
	memoffset@0.9.0
	minidl@0.1.5
	miniz_oxide@0.3.7
	miniz_oxide@0.7.1
	miow@0.5.0
	nix@0.26.2
	ntapi@0.4.1
	num-integer@0.1.45
	num-iter@0.1.43
	num-rational@0.3.2
	num-traits@0.2.15
	num_cpus@1.16.0
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	once_cell@1.18.0
	ordered-multimap@0.6.0
	pango-sys@0.18.0
	pango@0.18.0
	parking@2.1.0
	percent-encoding@2.3.0
	pest@2.7.0
	pin-project-lite@0.2.10
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pkg-config@0.3.27
	png@0.16.8
	ppv-lite86@0.2.17
	proc-macro-crate@1.3.1
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro-hack@0.5.20+deprecated
	proc-macro2@1.0.63
	proc-macro2@1.0.66
	quote@1.0.29
	quote@1.0.32
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	raw-cpuid@11.0.1
	rayon-core@1.11.0
	rayon@1.7.0
	redox_syscall@0.3.5
	regex-automata@0.3.2
	regex-syntax@0.7.3
	regex@1.9.1
	ring@0.16.20
	rusqlite@0.29.0
	rust-ini@0.19.0
	rustbus@0.19.2
	rustbus_derive@0.5.0
	rustc_version@0.3.3
	rustc_version@0.4.0
	rustix@0.38.13
	rustls-webpki@0.100.3
	rustls-webpki@0.101.5
	rustls@0.21.7
	ryu@1.0.14
	ryu@1.0.15
	same-file@1.0.6
	scopeguard@1.1.0
	scopeguard@1.2.0
	sct@0.7.0
	semver-parser@0.10.2
	semver@0.11.0
	semver@1.0.17
	semver@1.0.18
	serde@1.0.167
	serde@1.0.179
	serde_derive@1.0.167
	serde_derive@1.0.179
	serde_json@1.0.100
	serde_json@1.0.106
	serde_spanned@0.6.3
	sha2@0.10.7
	shared_memory_extended@0.13.0
	shell-escape@0.1.5
	slab@0.4.8
	smallvec@1.11.0
	spin@0.5.2
	spinning@0.1.0
	static_assertions@1.1.0
	syn@1.0.109
	syn@2.0.23
	syn@2.0.27
	sysinfo@0.29.4
	system-deps@6.1.1
	tar@0.4.40
	target-lexicon@0.12.8
	temp-dir@0.1.11
	tempfile@3.8.0
	textdistance@1.0.2
	thiserror-impl@1.0.43
	thiserror-impl@1.0.44
	thiserror@1.0.43
	thiserror@1.0.44
	tiny-keccak@2.0.2
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	to_method@1.1.0
	toml@0.7.6
	toml_datetime@0.6.3
	toml_edit@0.19.12
	typenum@1.16.0
	ucd-trie@0.1.6
	unicode-bidi@0.3.13
	unicode-ident@1.0.10
	unicode-ident@1.0.11
	unicode-normalization@0.1.22
	untrusted@0.7.1
	ureq@2.7.1
	url@2.4.1
	vcpkg@0.2.15
	vec_map@0.8.2
	version-compare@0.1.1
	version_check@0.9.4
	waker-fn@1.1.0
	walkdir@2.4.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-bindgen@0.2.87
	web-sys@0.3.64
	webpki-roots@0.23.1
	win-sys@0.3.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.42.0
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows@0.34.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.34.0
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.34.0
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.34.0
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.34.0
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.34.0
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	winnow@0.4.9
	xattr@1.0.1
	xml-rs@0.8.15
"

PYTHON_COMPAT=( python3_{9..11} )

PATHFINDER_COMMIT=21ec6fa933547636bc6c5ee8f0dd4a0ea3fcd062
NVTOP_COMMIT=be47f8c560487efc6e6a419d59c69bfbdb819324

declare -A GIT_CRATES=(
	[pathfinder_canvas]="https://github.com/servo/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/canvas/"
	[pathfinder_content]="https://github.com/servo/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/content/"
	[pathfinder_color]="https://github.com/servo/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/color/"
	[pathfinder_geometry]="https://github.com/servo/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/geometry/"
	[pathfinder_gl]="https://github.com/servo/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/gl/"
	[pathfinder_gpu]="https://github.com/servo/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/gpu/"
	[pathfinder_renderer]="https://github.com/servo/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/renderer/"
	[pathfinder_resources]="https://github.com/servo/pathfinder;${PATHFINDER_COMMIT};pathfinder-${PATHFINDER_COMMIT}/resources/"
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
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="
	dev-libs/wayland
	gui-libs/libadwaita
	>=gui-libs/gtk-4
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
	>=dev-util/meson-0.63
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
QA_FLAGS_IGNORED="usr/bin/${PN}"
