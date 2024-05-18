# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	atty-0.2.14
	autocfg-1.0.1
	base64-0.13.0
	bitflags-1.2.1
	block-buffer-0.9.0
	bumpalo-3.8.0
	bytes-1.1.0
	cc-1.0.72
	cfg-if-1.0.0
	chrono-0.4.19
	colored-1.9.3
	cpufeatures-0.2.1
	data-encoding-2.3.2
	der-oid-macro-0.5.0
	der-parser-6.0.0
	digest-0.9.0
	form_urlencoded-1.0.1
	futures-core-0.3.19
	futures-macro-0.3.19
	futures-task-0.3.19
	futures-util-0.3.19
	generic-array-0.14.4
	half-1.7.1
	hermit-abi-0.1.19
	idna-0.2.3
	instant-0.1.12
	itoa-0.4.8
	js-sys-0.3.55
	lazy_static-1.4.0
	libc-0.2.112
	lock_api-0.4.5
	log-0.4.14
	matches-0.1.9
	memchr-2.4.1
	mime-0.3.16
	minimal-lexical-0.2.1
	mio-0.7.14
	miow-0.3.7
	new_mime_guess-3.0.2
	nom-7.1.0
	ntapi-0.3.6
	num-bigint-0.4.3
	num-integer-0.1.44
	num-traits-0.2.14
	num_cpus-1.13.1
	oid-registry-0.2.0
	once_cell-1.9.0
	opaque-debug-0.3.0
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	percent-encoding-2.1.0
	pin-project-lite-0.2.7
	pin-utils-0.1.0
	proc-macro2-1.0.34
	quote-1.0.10
	redox_syscall-0.2.10
	ring-0.16.20
	rusticata-macros-4.0.0
	rustls-0.20.2
	rustls-pemfile-0.2.1
	scopeguard-1.1.0
	sct-0.7.0
	serde-1.0.132
	serde_derive-1.0.132
	sha2-0.9.8
	signal-hook-registry-1.4.0
	simple_logger-1.16.0
	slab-0.4.5
	smallvec-1.7.0
	spin-0.5.2
	syn-1.0.83
	thiserror-1.0.30
	thiserror-impl-1.0.30
	time-0.3.5
	time-macros-0.2.3
	tinyvec-1.5.1
	tinyvec_macros-0.1.0
	tokio-1.15.0
	tokio-macros-1.7.0
	tokio-rustls-0.23.2
	toml-0.5.8
	typenum-1.14.0
	unicase-2.6.0
	unicode-bidi-0.3.7
	unicode-normalization-0.1.19
	unicode-xid-0.2.2
	untrusted-0.7.1
	url-2.2.2
	version_check-0.9.3
	wasm-bindgen-0.2.78
	wasm-bindgen-backend-0.2.78
	wasm-bindgen-macro-0.2.78
	wasm-bindgen-macro-support-0.2.78
	wasm-bindgen-shared-0.2.78
	web-sys-0.3.55
	webpki-0.22.0
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	x509-parser-0.12.0
"

inherit cargo systemd

DESCRIPTION="A gemini Server written in rust"
HOMEPAGE="https://git.sr.ht/~int80h/gemserv"
SRC_URI="
	https://git.sr.ht/~int80h/gemserv/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"

S="${WORKDIR}/${PN}-v${PV}"

# openssl and SSLeay come from the “ring” crate.
LICENSE="Apache-2.0 BSD ISC MIT MPL-2.0 openssl SSLeay ZLIB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	acct-user/gemini
"
DEPEND="${RDEPEND}"

# Rust packages ignore CFLAGS and LDFLAGS so let's silence the QA warnings.
QA_FLAGS_IGNORED="usr/bin/gemserv"

src_prepare() {
	# Fix paths in systemd unit.
	sed -i 's@/path/to/bin /path/to/config@'"${EPREFIX}"'/usr/bin/gemserv '"${EPREFIX}"'/etc/gemserv/config.toml@' \
		init-scripts/gemserv.service || die

	# Fix paths in config.
	sed -Ei 's@/path/to/(key|cert)@/etc/gemserv/\1.pem@' config.toml || die
	sed -Ei 's@/path/to/serv@/var/gemini@' config.toml || die

	default
}

src_unpack() {
	unpack "${P}.tar.gz"
	cargo_src_unpack
}

src_install() {
	cargo_src_install

	einstalldocs

	diropts --group=gemini
	insinto etc/gemserv
	newins config.toml config.toml.example

	systemd_dounit init-scripts/gemserv.service
	newinitd "init-scripts/${PN}.openrc" "${PN}"
}

pkg_postinst() {
	einfo "You can generate yourself a TLS certificate and key with:"
	einfo "openssl req -x509 -newkey rsa:4096 -sha256 -days 3660 -nodes \\"
	einfo "    -keyout /etc/gemserv/key.pem -out /etc/gemserv/cert.pem"
}
