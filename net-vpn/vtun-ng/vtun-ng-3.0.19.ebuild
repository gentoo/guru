# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.1
	aes@0.8.4
	beef@0.5.2
	bitflags@2.9.1
	block-padding@0.3.3
	blowfish@0.9.1
	byteorder@1.5.0
	cbc@0.1.2
	cfb-mode@0.8.2
	cfg-if@1.0.1
	cipher@0.4.4
	cpufeatures@0.2.17
	crc32fast@1.5.0
	crypto-common@0.1.6
	deranged@0.4.0
	dns-lookup@2.0.4
	ecb@0.1.2
	errno@0.3.13
	flate2@1.1.2
	fnv@1.0.7
	generic-array@0.14.7
	getopts@0.2.23
	getrandom@0.3.3
	inout@0.1.4
	itoa@1.0.15
	lazy_static@1.5.0
	libc@0.2.174
	logos@0.15.0
	logos-codegen@0.15.0
	logos-derive@0.15.0
	md5@0.8.0
	miniz_oxide@0.8.9
	num-conv@0.1.0
	ofb@0.6.1
	powerfmt@0.2.0
	ppv-lite86@0.2.21
	proc-macro2@1.0.95
	proctitle@0.1.1
	quote@1.0.40
	r-efi@5.3.0
	rand@0.9.2
	rand_chacha@0.9.0
	rand_core@0.9.3
	regex-syntax@0.8.5
	rust-lzo@0.6.2
	rustc_version@0.4.1
	semver@1.0.26
	serde@1.0.219
	serde_derive@1.0.219
	signal-hook@0.3.18
	signal-hook-registry@1.4.5
	socket2@0.5.10
	syn@2.0.104
	time@0.3.41
	time-core@0.1.4
	time-macros@0.2.22
	typenum@1.18.0
	unicode-ident@1.0.18
	unicode-width@0.2.1
	version_check@0.9.5
	wasi@0.14.2+wasi-0.2.4
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.60.2
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows-targets@0.53.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_gnullvm@0.53.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_aarch64_msvc@0.53.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnu@0.53.0
	windows_i686_gnullvm@0.52.6
	windows_i686_gnullvm@0.53.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_i686_msvc@0.53.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnu@0.53.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnullvm@0.53.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	windows_x86_64_msvc@0.53.0
	wit-bindgen-rt@0.39.0
	zerocopy@0.8.26
	zerocopy-derive@0.8.26
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
IUSE="systemd"

DOCS=( ChangeLog Credits FAQ README README.Setup README.Shaper TODO )
CONFIG_CHECK="~TUN"

src_unpack() {
	cargo_src_unpack

	pushd "${S}" >/dev/null || die
	cargo_gen_config
	popd >/dev/null || die
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
