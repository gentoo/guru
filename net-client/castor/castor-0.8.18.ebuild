# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# NOTE: Generate new list with `cargo-ebuild ebuild` on every bump.
CRATES="
	aho-corasick-0.7.18
	ansi-parser-0.6.5
	atk-0.8.0
	atk-sys-0.9.1
	autocfg-1.0.1
	bitflags-1.3.2
	cairo-rs-0.8.1
	cairo-sys-rs-0.9.2
	cc-1.0.70
	cfg-if-1.0.0
	core-foundation-0.9.1
	core-foundation-sys-0.8.2
	dirs-3.0.2
	dirs-sys-0.3.6
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.0.1
	futures-channel-0.3.17
	futures-core-0.3.17
	futures-executor-0.3.17
	futures-io-0.3.17
	futures-macro-0.3.17
	futures-task-0.3.17
	futures-util-0.3.17
	gdk-0.12.1
	gdk-pixbuf-0.8.0
	gdk-pixbuf-sys-0.9.1
	gdk-sys-0.9.1
	getrandom-0.2.3
	gio-0.8.1
	gio-sys-0.9.1
	glib-0.9.3
	glib-sys-0.9.1
	gobject-sys-0.9.1
	gtk-0.8.1
	gtk-sys-0.9.2
	idna-0.2.3
	lazy_static-1.4.0
	libc-0.2.101
	linkify-0.7.0
	log-0.4.14
	matches-0.1.9
	memchr-2.4.1
	native-tls-0.2.8
	nom-4.2.3
	once_cell-1.8.0
	open-2.0.1
	openssl-0.10.36
	openssl-probe-0.1.4
	openssl-sys-0.9.66
	pango-0.8.0
	pango-sys-0.9.1
	pathdiff-0.2.0
	percent-encoding-2.1.0
	pin-project-lite-0.2.7
	pin-utils-0.1.0
	pkg-config-0.3.19
	ppv-lite86-0.2.10
	proc-macro-hack-0.5.19
	proc-macro-nested-0.1.7
	proc-macro2-1.0.29
	quote-1.0.9
	rand-0.8.4
	rand_chacha-0.3.1
	rand_core-0.6.3
	rand_hc-0.3.1
	redox_syscall-0.2.10
	redox_users-0.4.0
	regex-1.5.4
	regex-syntax-0.6.25
	remove_dir_all-0.5.3
	schannel-0.1.19
	security-framework-2.4.2
	security-framework-sys-2.4.2
	serde-1.0.130
	serde_derive-1.0.130
	slab-0.4.4
	smawk-0.3.1
	syn-1.0.76
	tempfile-3.2.0
	textwrap-0.14.2
	tinyvec-1.3.1
	tinyvec_macros-0.1.0
	toml-0.5.8
	unicode-bidi-0.3.6
	unicode-linebreak-0.1.2
	unicode-normalization-0.1.19
	unicode-width-0.1.8
	unicode-xid-0.2.2
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
	$(cargo_crate_uris ${CRATES})
"

# NOTE: Update after every dependency change (cargo-license helps).
LICENSE="Apache-2.0 MIT MPL-2.0"
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
