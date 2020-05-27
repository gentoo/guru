# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# NOTE: Generate new list with `cargo-ebuild ebuild` on every bump.
CRATES="
	aho-corasick-0.7.10
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
	cc-1.0.52
	cfg-if-0.1.10
	constant_time_eq-0.1.5
	core-foundation-0.7.0
	core-foundation-sys-0.7.0
	crossbeam-utils-0.7.2
	dirs-2.0.2
	dirs-sys-0.3.4
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
	libc-0.2.70
	log-0.4.8
	matches-0.1.8
	memchr-2.3.3
	native-tls-0.2.4
	nom-4.2.3
	once_cell-1.4.0
	open-1.4.0
	openssl-0.10.29
	openssl-probe-0.1.2
	openssl-sys-0.9.56
	pango-0.8.0
	pango-sys-0.9.1
	percent-encoding-2.1.0
	pin-project-0.4.16
	pin-project-internal-0.4.16
	pin-utils-0.1.0
	pkg-config-0.3.17
	ppv-lite86-0.2.6
	proc-macro-hack-0.5.15
	proc-macro-nested-0.1.4
	proc-macro2-1.0.12
	quote-1.0.5
	rand-0.7.3
	rand_chacha-0.2.2
	rand_core-0.5.1
	rand_hc-0.2.0
	redox_syscall-0.1.56
	redox_users-0.3.4
	regex-1.3.7
	regex-syntax-0.6.17
	remove_dir_all-0.5.2
	rust-argon2-0.7.0
	schannel-0.1.19
	security-framework-0.4.4
	security-framework-sys-0.4.3
	serde-1.0.110
	serde_derive-1.0.110
	slab-0.4.2
	smallvec-1.4.0
	syn-1.0.21
	tempfile-3.1.0
	thread_local-1.0.1
	toml-0.5.6
	unicode-bidi-0.3.4
	unicode-normalization-0.1.12
	unicode-xid-0.2.0
	url-2.1.1
	vcpkg-0.2.8
	version_check-0.1.5
	wasi-0.9.0+wasi-snapshot-preview1
	winapi-0.3.8
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

LICENSE="Apache-2.0 BSD-2 CC0-1.0 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/openssl
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"

src_prepare() {
	xdg_src_prepare

	# Upstream uses forks to support LibreSSL. We revert to official sources.
	sed -Ei 's/(native-tls|openssl(-sys)?) = \{.+/\1 = "*"/' Cargo.toml || die

	# Fix Desktop entry.
	sed -Ei 's/Icon=(.+)\.png/Icon=\1/' data/Castor.desktop || die
	sed -i 's/Categories=Browser/Categories=Network/' data/Castor.desktop || die
}

src_test() {
	# FIXME: test absolute_url::test_make_absolute_just_path fails without this.
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
