# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@0.7.19
	android_system_properties@0.1.5
	ansi_term@0.12.1
	anyhow@1.0.65
	atomic_refcell@0.1.8
	autocfg@1.1.0
	bitflags@1.3.2
	block@0.1.6
	bumpalo@3.11.0
	cairo-rs@0.16.7
	cairo-sys-rs@0.16.3
	cc@1.0.73
	cfg-expr@0.10.3
	cfg-if@1.0.0
	chrono@0.4.22
	color_quant@1.1.0
	core-foundation-sys@0.8.3
	field-offset@0.3.4
	fragile@2.0.0
	futures-channel@0.3.24
	futures-core@0.3.24
	futures-executor@0.3.24
	futures-io@0.3.24
	futures-macro@0.3.24
	futures-task@0.3.24
	futures-util@0.3.24
	gdk-pixbuf@0.16.7
	gdk-pixbuf-sys@0.16.3
	gdk4@0.5.4
	gdk4-sys@0.5.4
	gdk4-wayland@0.5.4
	gdk4-wayland-sys@0.5.4
	gdk4-x11@0.5.4
	gdk4-x11-sys@0.5.4
	gettext-rs@0.7.0
	gettext-sys@0.21.3
	gif@0.12.0
	gio@0.16.7
	gio-sys@0.16.3
	glib@0.15.12
	glib@0.16.7
	glib-macros@0.15.11
	glib-macros@0.16.3
	glib-sys@0.15.10
	glib-sys@0.16.3
	gobject-sys@0.15.10
	gobject-sys@0.16.3
	graphene-rs@0.16.3
	graphene-sys@0.16.3
	gsettings-macro@0.1.14
	gsk4@0.5.4
	gsk4-sys@0.5.4
	gst-plugin-gif@0.9.2
	gst-plugin-gtk4@0.9.3
	gst-plugin-version-helper@0.7.3
	gstreamer@0.19.4
	gstreamer-audio@0.19.4
	gstreamer-audio-sys@0.19.4
	gstreamer-base@0.19.3
	gstreamer-base-sys@0.19.3
	gstreamer-pbutils@0.19.2
	gstreamer-pbutils-sys@0.19.2
	gstreamer-sys@0.19.4
	gstreamer-video@0.19.4
	gstreamer-video-sys@0.19.4
	gtk4@0.5.4
	gtk4-macros@0.5.4
	gtk4-sys@0.5.4
	heck@0.4.0
	iana-time-zone@0.1.48
	js-sys@0.3.60
	lazy_static@1.4.0
	libadwaita@0.2.1
	libadwaita-sys@0.2.1
	libc@0.2.132
	libpulse-binding@2.26.0
	libpulse-glib-binding@2.25.1
	libpulse-mainloop-glib-sys@1.19.2
	libpulse-sys@1.19.3
	locale_config@0.3.0
	log@0.4.17
	malloc_buf@0.0.6
	memchr@2.5.0
	memoffset@0.6.5
	muldiv@1.0.0
	num-derive@0.3.3
	num-integer@0.1.45
	num-rational@0.4.1
	num-traits@0.2.15
	objc@0.2.7
	objc-foundation@0.1.1
	objc_id@0.1.1
	once_cell@1.14.0
	option-operations@0.5.0
	pango@0.16.5
	pango-sys@0.16.3
	paste@1.0.9
	pest@2.3.1
	pin-project-lite@0.2.9
	pin-utils@0.1.0
	pkg-config@0.3.25
	pretty-hex@0.3.0
	proc-macro-crate@1.2.1
	proc-macro-error@1.0.4
	proc-macro-error-attr@1.0.4
	proc-macro2@1.0.43
	quick-xml@0.25.0
	quote@1.0.21
	regex@1.6.0
	regex-syntax@0.6.27
	rustc_version@0.3.3
	semver@0.11.0
	semver-parser@0.10.2
	serde@1.0.144
	serde_derive@1.0.144
	sharded-slab@0.1.4
	slab@0.4.7
	smallvec@1.9.0
	syn@1.0.99
	system-deps@6.0.2
	temp-dir@0.1.11
	thiserror@1.0.35
	thiserror-impl@1.0.35
	thread_local@1.1.4
	toml@0.5.9
	tracing@0.1.36
	tracing-attributes@0.1.22
	tracing-core@0.1.29
	tracing-log@0.1.3
	tracing-subscriber@0.3.15
	ucd-trie@0.1.5
	unicode-ident@1.0.4
	valuable@0.1.0
	version-compare@0.1.0
	version_check@0.9.4
	wasm-bindgen@0.2.83
	wasm-bindgen-backend@0.2.83
	wasm-bindgen-macro@0.2.83
	wasm-bindgen-macro-support@0.2.83
	wasm-bindgen-shared@0.2.83
	weezl@0.1.7
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
"

inherit cargo meson xdg gnome2-utils

DESCRIPTION="GTK4 screen recorder for Wayland"
HOMEPAGE="https://github.com/SeaDve/Kooha/"
SRC_URI="https://github.com/SeaDve/Kooha/releases/download/v${PV}/kooha-${PV}.tar.xz
${cargo_crate_uris}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="x264 vaapi test"
RESTRICT="!test? ( test )"

DEPEND="
		x264? ( >=media-libs/x264-0.0.20220222
				>=media-libs/gst-plugins-ugly-1.20.6 )
		>=media-libs/gstreamer-1.20.6
		>=media-libs/gst-plugins-base-1.20.6
		vaapi? ( >=media-plugins/gst-plugins-vaapi-1.20.6 )
		>=dev-libs/glib-2.76.3
		>=gui-libs/gtk-4.10.4
		>=gui-libs/libadwaita-1.3.3
		>=media-libs/libpulse-15.0[glib]
		>=media-video/pipewire-0.3.77-r1[gstreamer]
		>=sys-apps/xdg-desktop-portal-1.16.0-r1
"
RDEPEND="${DEPEND}"
BDEPEND="
		app-alternatives/ninja
		>=dev-util/meson-1.1.1
		>=dev-libs/appstream-glib-0.8.2
		>=virtual/rust-1.69.0
		test? ( || ( dev-lang/rust[clippy]
					 dev-lang/rust-bin[clippy] ) )
"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

BUILD_DIR="${S}/build"

src_prepare() {
	default

	sed -i \
		-e '/^gnome.post_install(/,/)/d' \
		meson.build \
		|| die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
