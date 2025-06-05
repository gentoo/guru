# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	aho-corasick@1.1.3
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	anyhow@1.0.91
	async-broadcast@0.5.1
	async-channel@2.3.1
	async-executor@1.13.1
	async-fs@1.6.0
	async-io@1.13.0
	async-io@2.3.4
	async-lock@2.8.0
	async-lock@3.4.0
	async-process@1.8.1
	async-recursion@1.1.1
	async-signal@0.2.10
	async-task@4.7.1
	async-trait@0.1.83
	atomic-waker@1.1.2
	autocfg@1.4.0
	backtrace@0.3.74
	bitflags@1.3.2
	bitflags@2.6.0
	block-buffer@0.10.4
	blocking@1.6.1
	byteorder@1.5.0
	bytes@1.8.0
	cc@1.1.31
	cfg-if@1.0.0
	clap@4.5.20
	clap_builder@4.5.20
	clap_derive@4.5.18
	clap_lex@0.7.2
	colorchoice@1.0.2
	concat-in-place@1.1.0
	concurrent-queue@2.5.0
	cpufeatures@0.2.14
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	darling@0.20.10
	darling_core@0.20.10
	darling_macro@0.20.10
	derivative@2.2.0
	derive_setters@0.1.6
	digest@0.10.7
	enumflags2@0.7.10
	enumflags2_derive@0.7.10
	env_filter@0.1.3
	env_logger@0.11.7
	equivalent@1.0.1
	errno@0.3.9
	event-listener-strategy@0.5.2
	event-listener@2.5.3
	event-listener@3.1.0
	event-listener@5.3.1
	fastrand@1.9.0
	fastrand@2.1.1
	fern@0.6.2
	fnv@1.0.7
	futures-core@0.3.31
	futures-io@0.3.31
	futures-lite@1.13.0
	futures-lite@2.3.0
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	generic-array@0.14.7
	getrandom@0.2.15
	gimli@0.31.1
	hashbrown@0.15.0
	heck@0.5.0
	hermit-abi@0.3.9
	hermit-abi@0.4.0
	hex@0.4.3
	hidapi@1.5.0
	ident_case@1.0.1
	indexmap@2.6.0
	inotify-sys@0.1.5
	inotify@0.10.2
	instant@0.1.13
	intel-pstate@1.0.1
	io-lifetimes@1.0.11
	is_terminal_polyfill@1.70.1
	itoa@1.0.11
	jiff-static@0.2.5
	jiff@0.2.5
	libc@0.2.161
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.14
	log@0.4.22
	memchr@2.7.4
	memoffset@0.7.1
	memoffset@0.9.1
	miniz_oxide@0.8.0
	mio@1.0.2
	nix@0.26.4
	numtoa@0.2.4
	object@0.36.5
	once_cell@1.20.2
	ordered-stream@0.2.0
	parking@2.2.1
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	piper@0.2.4
	pkg-config@0.3.31
	polling@2.8.0
	polling@3.7.3
	portable-atomic-util@0.2.4
	portable-atomic@1.11.0
	ppv-lite86@0.2.20
	proc-macro-crate@1.3.1
	proc-macro2@1.0.94
	quote@1.0.40
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	regex-automata@0.4.8
	regex-syntax@0.8.5
	regex@1.11.0
	rustc-demangle@0.1.24
	rustix@0.37.27
	rustix@0.38.37
	ryu@1.0.18
	serde@1.0.213
	serde_derive@1.0.213
	serde_json@1.0.132
	serde_repr@0.1.19
	sha1@0.10.6
	shlex@1.3.0
	signal-hook-registry@1.4.2
	slab@0.4.9
	smart-default@0.6.0
	socket2@0.4.10
	socket2@0.5.7
	static_assertions@1.1.0
	strsim@0.11.1
	syn@1.0.109
	syn@2.0.100
	tempfile@3.13.0
	thiserror-impl@1.0.65
	thiserror@1.0.65
	tokio-macros@2.4.0
	tokio@1.41.0
	toml_datetime@0.6.8
	toml_edit@0.19.15
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	typenum@1.17.0
	uds_windows@1.1.0
	unicode-ident@1.0.13
	utf8parse@0.2.2
	version_check@0.9.5
	waker-fn@1.2.0
	wasi@0.11.0+wasi-snapshot-preview1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winnow@0.5.40
	xdg-home@1.3.0
	zbus@3.15.2
	zbus_macros@3.15.2
	zbus_names@2.6.1
	zbus_polkit@3.0.1
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zvariant@3.15.2
	zvariant_derive@3.15.2
	zvariant_utils@1.0.1
"

declare -A GIT_CRATES=(
	[sysfs-class]='https://github.com/pop-os/sysfs-class;ab63e7f638aadfaf896a02e53cf330343d331337;sysfs-class-%commit%'
)

inherit cargo

DESCRIPTION="System76 Power Management Tool"
HOMEPAGE="https://github.com/pop-os/system76-power"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/pop-os/system76-power"
else
	SRC_URI="
		https://github.com/pop-os/system76-power/archive/refs/tags/${PV}.tar.gz
		-> ${P}.tar.gz
		${CARGO_CRATE_URIS}
	"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	BSD ISC MIT Unicode-DFS-2016
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"

DEPEND="virtual/libusb:1"
RDEPEND="
	${DEPEND}
	sys-apps/dbus
	sys-auth/polkit
"
BDEPEND="virtual/pkgconfig"

src_unpack(){
	if [[ ${PV} == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_prepare() {
	# Install the Rust binary using the cargo eclass as the Makefile hardcodes the release path
	sed -i '/\s*install -D -m 0755/d' Makefile || die
	default
}

src_configure() {
	if [[ ${PV} == *9999* ]]; then
		# prevent network access during src_install due to git crate sysfs-class
		cargo_src_configure --frozen
	else
		cargo_src_configure
	fi
}

src_install(){
	cargo_src_install
	emake DESTDIR="${D}" prefix="${EPREFIX}/usr" install
	elog "Enable the service: 'systemctl enable --now com.system76.PowerDaemon.service'"
}

pkg_postinst(){
	if ! has_version sys-apps/systemd; then
		ewarn "${PN} is not functional without sys-apps/systemd at this point."
	fi
}
