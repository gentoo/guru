# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.1
	aead@0.5.2
	aes@0.8.4
	aes-gcm@0.10.3
	aes-gcm-siv@0.11.1
	beef@0.5.2
	block-buffer@0.10.4
	block-padding@0.3.3
	blowfish@0.9.1
	byteorder@1.5.0
	cbc@0.1.2
	cfb-mode@0.8.2
	cfg-if@1.0.4
	chacha20@0.9.1
	chacha20poly1305@0.10.1
	cipher@0.4.4
	cpufeatures@0.2.17
	crc32fast@1.5.0
	crypto-common@0.1.7
	ctr@0.9.2
	deranged@0.5.8
	digest@0.10.7
	dns-lookup@2.1.1
	ecb@0.1.2
	errno@0.3.14
	flate2@1.1.9
	fnv@1.0.7
	generic-array@0.14.7
	getopts@0.2.24
	getrandom@0.2.17
	getrandom@0.3.4
	ghash@0.5.1
	inout@0.1.4
	lazy_static@1.5.0
	libc@0.2.186
	log@0.4.33
	logos@0.15.1
	logos-codegen@0.15.1
	logos-derive@0.15.1
	md5@0.8.0
	miniz_oxide@0.8.9
	num-conv@0.2.2
	ofb@0.6.1
	opaque-debug@0.3.1
	poly1305@0.8.0
	polyval@0.6.2
	powerfmt@0.2.0
	ppv-lite86@0.2.21
	proc-macro2@1.0.106
	proctitle@0.1.1
	quote@1.0.46
	r-efi@5.3.0
	rand@0.9.4
	rand_chacha@0.9.0
	rand_core@0.6.4
	rand_core@0.9.5
	regex-syntax@0.8.11
	rust-lzo@0.6.2
	rustc_version@0.4.1
	semver@1.0.28
	serde_core@1.0.228
	serde_derive@1.0.228
	sha2@0.10.9
	signal-hook@0.3.18
	signal-hook-registry@1.4.8
	simd-adler32@0.3.9
	socket2@0.6.4
	subtle@2.6.1
	syn@2.0.118
	time@0.3.52
	time-core@0.1.9
	time-macros@0.2.31
	typenum@1.20.1
	unicode-ident@1.0.24
	unicode-width@0.2.2
	universal-hash@0.5.1
	uzers@0.12.2
	version_check@0.9.5
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.4+wasi-0.2.12
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-link@0.2.1
	windows-sys@0.60.2
	windows-sys@0.61.2
	windows-targets@0.53.5
	windows_aarch64_gnullvm@0.53.1
	windows_aarch64_msvc@0.53.1
	windows_i686_gnu@0.53.1
	windows_i686_gnullvm@0.53.1
	windows_i686_msvc@0.53.1
	windows_x86_64_gnu@0.53.1
	windows_x86_64_gnullvm@0.53.1
	windows_x86_64_msvc@0.53.1
	wit-bindgen@0.57.1
	zerocopy@0.8.52
	zerocopy-derive@0.8.52
	zeroize@1.9.0
"

inherit cargo systemd

DESCRIPTION="Create tunnels over TCP/IP networks with shaping, encryption, and compression"
HOMEPAGE="https://github.com/leakingmemory/vtun-ng"
SRC_URI="${CARGO_CRATE_URIS}
	https://github.com/leakingmemory/vtun-ng/releases/download/v${PV}/${P}.tar.gz
	"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~ppc"
IUSE="systemd +lzo"

RUST_MIN_VER="1.88.0"

DOCS=( ChangeLog Credits FAQ README README.Setup README.Shaper TODO )
CONFIG_CHECK="~TUN"

src_unpack() {
	cargo_src_unpack

	pushd "${S}" >/dev/null || die
	cargo_gen_config
	popd >/dev/null || die
}

src_configure() {
	local myfeatures=(
		$(usev lzo)
	)
	cargo_src_configure
}

src_compile() {
	export VTUN_STAT_DIR=/var/log/vtunngd
	export VTUN_LOCK_DIR=/var/lock/vtunngd
	export ENABLE_NAT_HACK=1
	export VTUN_CONFIG_FILE=/etc/vtunngd.conf
	export VTUN_PID_FILE=/var/run/vtunngd.pid
	cargo_src_compile
}

src_install() {
	export INSTALL_PREFIX="${D}"
	export DESTDIR=/
	./install.sh
	newinitd "${FILESDIR}"/vtunng.rc vtunng
	insinto /etc
	doins "${FILESDIR}"/vtunngd-start.conf
	if use systemd; then
		insinto /etc/vtunngd
		newins "${S}"/scripts/sample-client.env.systemd sample-client.env
	fi
	systemd_newunit "${S}"/scripts/vtunngd.service.systemd vtunngd.service
	systemd_newunit "${S}"/scripts/vtunngd-client.service.systemd vtunngd@.service
}

src_test() { :; }
