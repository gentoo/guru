# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick-0.7.18
	ansi-parser-0.6.5
	atk-0.8.0
	atk-sys-0.9.1
	autocfg-0.1.8
	autocfg-1.1.0
	bitflags-1.3.2
	cairo-rs-0.8.1
	cairo-sys-rs-0.9.2
	cc-1.0.73
	cfg-if-0.1.10
	cfg-if-1.0.0
	cloudabi-0.0.3
	core-foundation-0.7.0
	core-foundation-sys-0.7.0
	dirs-3.0.2
	dirs-sys-0.3.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	fuchsia-cprng-0.1.1
	futures-channel-0.3.21
	futures-core-0.3.21
	futures-executor-0.3.21
	futures-io-0.3.21
	futures-macro-0.3.21
	futures-task-0.3.21
	futures-util-0.3.21
	gdk-0.12.1
	gdk-pixbuf-0.8.0
	gdk-pixbuf-sys-0.9.1
	gdk-sys-0.9.1
	getrandom-0.2.6
	gio-0.8.1
	gio-sys-0.9.1
	glib-0.9.3
	glib-sys-0.9.1
	gobject-sys-0.9.1
	gtk-0.8.1
	gtk-sys-0.9.2
	idna-0.2.3
	lazy_static-1.4.0
	libc-0.2.125
	linkify-0.7.0
	log-0.4.17
	matches-0.1.9
	memchr-2.5.0
	native-tls-0.2.4
	nom-4.2.3
	once_cell-1.10.0
	open-2.0.3
	openssl-0.10.40
	openssl-macros-0.1.0
	openssl-probe-0.1.5
	openssl-sys-0.9.73
	pango-0.8.0
	pango-sys-0.9.1
	pathdiff-0.2.1
	percent-encoding-2.1.0
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pkg-config-0.3.25
	proc-macro2-1.0.38
	quote-1.0.18
	rand-0.6.5
	rand_chacha-0.1.1
	rand_core-0.3.1
	rand_core-0.4.2
	rand_hc-0.1.0
	rand_isaac-0.1.1
	rand_jitter-0.1.4
	rand_os-0.1.3
	rand_pcg-0.1.2
	rand_xorshift-0.1.1
	rdrand-0.4.0
	redox_syscall-0.1.57
	redox_syscall-0.2.13
	redox_users-0.4.3
	regex-1.5.5
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	schannel-0.1.19
	security-framework-0.4.4
	security-framework-sys-0.4.3
	serde-1.0.137
	serde_derive-1.0.137
	slab-0.4.6
	smawk-0.3.1
	syn-1.0.94
	tempfile-3.0.8
	textwrap-0.14.2
	thiserror-1.0.31
	thiserror-impl-1.0.31
	tinyvec-1.6.0
	tinyvec_macros-0.1.0
	toml-0.5.9
	unicode-bidi-0.3.8
	unicode-linebreak-0.1.2
	unicode-normalization-0.1.19
	unicode-width-0.1.9
	unicode-xid-0.2.3
	url-2.2.2
	vcpkg-0.2.15
	version_check-0.1.5
	wasi-0.10.2+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo desktop xdg

DESCRIPTION="A graphical browser for plain-text protocols"
HOMEPAGE="https://git.sr.ht/~julienxx/castor"
SRC_URI="
	https://git.sr.ht/~julienxx/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris)
"

# NOTE: Update after every dependency change (cargo-license helps)
LICENSE="Apache-2.0 BSD-2 ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/atk
	dev-libs/glib:2
	dev-libs/openssl:=
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

# Rust packages ignore CFLAGS and LDFLAGS so let's silence the QA warnings
QA_FLAGS_IGNORED="usr/bin/castor"

src_test() {
	# FIXME: test absolute_url::test_make_absolute_just_path fails without this,
	# but I couldn't reproduce it.
	RUST_BACKTRACE=1 cargo_src_test
}

src_install() {
	cargo_src_install

	einstalldocs
	newdoc data/castor_settings.toml.example settings.toml.example

	doicon data/org.typed-hole.castor.svg
	for icon in data/org.typed-hole.castor-*.png; do
		local size=$(grep -Eo '[0-9]{2,3}' <<<${icon})
		newicon --size ${size} ${icon} $(basename ${icon/-${size}/})
	done
	domenu data/Castor.desktop
}
