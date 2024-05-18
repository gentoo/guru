# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aho-corasick@1.1.2
	anstream@0.6.4
	anstyle-parse@0.2.2
	anstyle-query@1.0.0
	anstyle-wincon@3.0.1
	anstyle@1.0.4
	anyhow@1.0.75
	anymap2@0.13.0
	autocfg@1.1.0
	backtrace@0.3.69
	base64@0.21.5
	bitflags@1.3.2
	bitflags@2.4.1
	block-buffer@0.10.4
	bytes@1.5.0
	cc@1.0.83
	cfg-if@1.0.0
	clap@4.4.8
	clap_builder@4.4.8
	clap_lex@0.6.0
	colorchoice@1.0.0
	const_format@0.2.32
	const_format_proc_macros@0.2.32
	cpufeatures@0.2.11
	crossbeam-channel@0.5.8
	crossbeam-utils@0.8.16
	crypto-common@0.1.6
	deranged@0.3.9
	digest@0.10.7
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	dirs-sys@0.4.1
	dirs@5.0.1
	doc-comment@0.3.3
	either@1.9.0
	equivalent@1.0.1
	errno@0.3.7
	fastrand@2.0.1
	futures-channel@0.3.29
	futures-core@0.3.29
	futures-executor@0.3.29
	futures-io@0.3.29
	futures-macro@0.3.29
	futures-sink@0.3.29
	futures-task@0.3.29
	futures-util@0.3.29
	futures@0.3.29
	generic-array@0.14.7
	getrandom@0.2.11
	gimli@0.28.0
	git-version-macro@0.3.8
	git-version@0.3.8
	hashbrown@0.14.2
	hermit-abi@0.3.3
	indexmap@2.1.0
	inventory@0.3.13
	itertools@0.10.5
	itoa@1.0.9
	kstring@2.0.0
	lazy_static@1.4.0
	lefthk-core@0.2.0
	leftwm-layouts@0.8.4
	libc@0.2.150
	libredox@0.0.1
	linux-raw-sys@0.4.11
	liquid-core@0.26.4
	liquid-derive@0.26.4
	liquid-lib@0.26.4
	liquid@0.26.4
	log@0.4.20
	matchers@0.1.0
	memchr@2.6.4
	miniz_oxide@0.7.1
	mio@0.8.9
	nix@0.27.1
	nu-ansi-term@0.46.0
	num-traits@0.2.17
	num_cpus@1.16.0
	num_threads@0.1.6
	object@0.32.1
	once_cell@1.18.0
	option-ext@0.2.0
	overload@0.1.1
	percent-encoding@2.3.0
	pest@2.7.5
	pest_derive@2.7.5
	pest_generator@2.7.5
	pest_meta@2.7.5
	pin-project-lite@0.2.13
	pin-utils@0.1.0
	pkg-config@0.3.27
	powerfmt@0.2.0
	proc-macro2@1.0.69
	quote@1.0.33
	redox_syscall@0.4.1
	redox_users@0.4.4
	regex-automata@0.1.10
	regex-automata@0.4.3
	regex-syntax@0.6.29
	regex-syntax@0.8.2
	regex@1.10.2
	ron@0.8.1
	rustc-demangle@0.1.23
	rustix@0.38.24
	ryu@1.0.15
	serde@1.0.192
	serde_derive@1.0.192
	serde_json@1.0.108
	serde_spanned@0.6.4
	sha2@0.10.8
	sharded-slab@0.1.7
	shellexpand@3.1.0
	signal-hook-registry@1.4.1
	signal-hook@0.3.17
	slab@0.4.9
	smallvec@1.11.2
	socket2@0.5.5
	static_assertions@1.1.0
	strsim@0.10.0
	syn@2.0.39
	syslog-tracing@0.2.0
	tempfile@3.8.1
	thiserror-impl@1.0.50
	thiserror@1.0.50
	thread_local@1.1.7
	time-core@0.1.2
	time-macros@0.2.15
	time@0.3.30
	tokio-macros@2.2.0
	tokio@1.34.0
	toml@0.8.8
	toml_datetime@0.6.5
	toml_edit@0.21.0
	tracing-appender@0.2.3
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing-journald@0.3.0
	tracing-log@0.2.0
	tracing-subscriber@0.3.18
	tracing@0.1.40
	typenum@1.17.0
	ucd-trie@0.1.6
	unicode-ident@1.0.12
	unicode-segmentation@1.10.1
	unicode-xid@0.2.4
	utf8parse@0.2.1
	valuable@0.1.0
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	winnow@0.5.19
	x11-dl@2.21.0
	xdg@2.5.2
"

inherit cargo

DESCRIPTION="A window manager for Adventurers"
HOMEPAGE="https://github.com/leftwm/leftwm"
SRC_URI="
	https://github.com/leftwm/leftwm/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	BSD-2 BSD MIT MPL-2.0 Unicode-DFS-2016 ZLIB
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+lefthk syslog systemd"

DEPEND="
	x11-apps/xrandr
	x11-libs/libX11
	x11-libs/libXinerama
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-nolefthk.patch" )

QA_FLAGS_IGNORED="usr/bin/.*"

src_configure() {
	local myfeatures=(
		$(usev lefthk)
		$(usev systemd journald-log)
		$(usev syslog sys-log)
	)
	cargo_src_configure --no-default-features
}

src_install() {
	dodoc README.md CHANGELOG.md
	doman leftwm/doc/leftwm.1

	insinto /usr/share/xsessions
	doins leftwm.desktop

	bins="target/$(usex debug debug release)"
	dobin "${bins}"/leftwm{,-worker,-state,-check,-command}
	use lefthk && dobin "${bins}"/lefthk-worker
}
