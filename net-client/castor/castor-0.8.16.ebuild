# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# NOTE: Generate new list with `cargo-ebuild ebuild` on every bump.
CRATES="
	aho-corasick-0.7.13
	ansi-parser-0.6.5
	arrayref-0.3.6
	arrayvec-0.5.1
	atk-0.8.0
	atk-sys-0.9.1
	autocfg-1.0.0
	base64-0.11.0
	bitflags-1.2.1
	blake2b_simd-0.5.10
	cairo-rs-0.8.1
	cairo-sys-rs-0.9.2
	cc-1.0.55
	cfg-if-0.1.10
	constant_time_eq-0.1.5
	core-foundation-0.7.0
	core-foundation-sys-0.7.0
	crossbeam-utils-0.7.2
	dirs-2.0.2
	dirs-sys-0.3.5
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	futures-channel-0.3.5
	futures-core-0.3.5
	futures-executor-0.3.5
	futures-io-0.3.5
	futures-macro-0.3.5
	futures-task-0.3.5
	futures-util-0.3.5
	gdk-0.12.1
	gdk-pixbuf-0.8.0
	gdk-pixbuf-sys-0.9.1
	gdk-sys-0.9.1
	getrandom-0.1.14
	gio-0.8.1
	gio-sys-0.9.1
	glib-0.9.3
	glib-sys-0.9.1
	gobject-sys-0.9.1
	gtk-0.8.1
	gtk-sys-0.9.2
	idna-0.2.0
	lazy_static-1.4.0
	libc-0.2.71
	linkify-0.4.0
	log-0.4.8
	matches-0.1.8
	memchr-2.3.3
	native-tls-0.2.4
	nom-4.2.3
	once_cell-1.4.0
	open-1.4.0
	openssl-0.10.30
	openssl-probe-0.1.2
	openssl-sys-0.9.58
	pango-0.8.0
	pango-sys-0.9.1
	percent-encoding-2.1.0
	pin-project-0.4.22
	pin-project-internal-0.4.22
	pin-utils-0.1.0
	pkg-config-0.3.17
	ppv-lite86-0.2.8
	proc-macro-hack-0.5.16
	proc-macro-nested-0.1.6
	proc-macro2-1.0.18
	quote-1.0.7
	rand-0.7.3
	rand_chacha-0.2.2
	rand_core-0.5.1
	rand_hc-0.2.0
	redox_syscall-0.1.56
	redox_users-0.3.4
	regex-1.3.9
	regex-syntax-0.6.18
	remove_dir_all-0.5.3
	rust-argon2-0.7.0
	schannel-0.1.19
	security-framework-0.4.4
	security-framework-sys-0.4.3
	serde-1.0.114
	serde_derive-1.0.114
	slab-0.4.2
	syn-1.0.33
	tempfile-3.1.0
	textwrap-0.11.0
	thread_local-1.0.1
	tinyvec-0.3.3
	toml-0.5.6
	unicode-bidi-0.3.4
	unicode-normalization-0.1.13
	unicode-width-0.1.7
	unicode-xid-0.2.1
	url-2.1.1
	vcpkg-0.2.10
	version_check-0.1.5
	wasi-0.9.0+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit cargo desktop xdg

DESCRIPTION="A graphical browser for plain-text protocols"
HOMEPAGE="https://git.sr.ht/~julienxx/castor"
SRC_URI="
	https://git.sr.ht/~julienxx/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"

# NOTE: Update after every dependency change (cargo-license helps).
LICENSE="Apache-2.0 BSD-2 CC0-1.0 MIT MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/openssl
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"

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
