# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	arc-swap-0.4.7
	atty-0.2.14
	autocfg-1.0.0
	bitflags-1.2.1
	bytes-0.5.6
	cc-1.0.58
	cfg-if-0.1.10
	chrono-0.4.15
	colored-1.9.3
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	fuchsia-zircon-0.3.3
	fuchsia-zircon-sys-0.3.3
	futures-core-0.3.5
	futures-macro-0.3.5
	futures-task-0.3.5
	futures-util-0.3.5
	hermit-abi-0.1.15
	idna-0.2.0
	iovec-0.1.4
	kernel32-sys-0.2.2
	lazy_static-1.4.0
	libc-0.2.74
	log-0.4.11
	matches-0.1.8
	memchr-2.3.3
	mime-0.3.16
	mime_guess-2.0.3
	mio-0.6.22
	mio-named-pipes-0.1.7
	mio-uds-0.6.8
	miow-0.2.1
	miow-0.3.5
	net2-0.2.34
	num-integer-0.1.43
	num-traits-0.2.12
	num_cpus-1.13.0
	once_cell-1.4.0
	openssl-0.10.30
	openssl-sys-0.9.58
	percent-encoding-2.1.0
	pin-project-0.4.23
	pin-project-internal-0.4.23
	pin-project-lite-0.1.7
	pin-utils-0.1.0
	pkg-config-0.3.18
	proc-macro-hack-0.5.18
	proc-macro-nested-0.1.6
	proc-macro2-1.0.19
	quote-1.0.7
	redox_syscall-0.1.57
	serde-1.0.115
	serde_derive-1.0.115
	signal-hook-registry-1.2.1
	simple_logger-1.6.0
	slab-0.4.2
	socket2-0.3.12
	syn-1.0.38
	time-0.1.43
	tinyvec-0.3.3
	tokio-0.2.22
	tokio-openssl-0.4.0
	toml-0.5.6
	unicase-2.6.0
	unicode-bidi-0.3.4
	unicode-normalization-0.1.13
	unicode-xid-0.2.1
	url-2.1.1
	vcpkg-0.2.10
	version_check-0.9.2
	winapi-0.2.8
	winapi-0.3.9
	winapi-build-0.1.1
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
	ws2_32-sys-0.2.1
"

inherit cargo systemd

DESCRIPTION="A gemini Server written in rust"
HOMEPAGE="
	gemini://80h.dev/projects/gemserv/
	https://git.sr.ht/~int80h/gemserv
"
SRC_URI="
	https://git.sr.ht/~int80h/gemserv/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(cargo_crate_uris ${CRATES})
"

LICENSE="Apache-2.0 BSD MIT MPL-2.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-libs/openssl-1.1.0g
	acct-user/gemini
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-v${PV}"

src_prepare() {
	# Fix paths in systemd unit.
	sed -i "s@/path/to/bin /path/to/config@${EPREFIX}/usr/bin/gemserv ${EPREFIX}/etc/gemserv/config.toml@" \
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
