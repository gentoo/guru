# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.3
	anstream@0.3.2
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@1.0.1
	anstyle@1.0.1
	autocfg@1.3.0
	base64@0.21.7
	bitflags@1.3.2
	bitflags@2.5.0
	byteorder@1.4.3
	calloop-wayland-source@0.3.0
	calloop@0.13.0
	cc@1.0.97
	cfg-if@1.0.0
	clap@4.3.8
	clap_builder@4.3.8
	clap_derive@4.3.2
	clap_lex@0.5.0
	colorchoice@1.0.0
	concurrent-queue@2.5.0
	crossbeam-utils@0.8.19
	dlib@0.5.2
	doc-comment@0.3.3
	downcast-rs@1.2.0
	either@1.11.0
	env_logger@0.10.2
	errno@0.3.9
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-timer@3.0.3
	futures-util@0.3.30
	futures@0.3.30
	fxhash@0.2.1
	glob@0.3.1
	hashbrown@0.12.3
	heck@0.4.1
	hermit-abi@0.3.9
	hopcroft-karp@0.2.1
	humantime@2.1.0
	indexmap@1.9.3
	is-terminal@0.4.12
	itertools@0.12.1
	libc@0.2.155
	libloading@0.8.0
	linux-raw-sys@0.4.13
	log@0.4.21
	memchr@2.7.2
	once_cell@1.18.0
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	pkg-config@0.3.27
	polling@3.7.0
	proc-macro2@1.0.82
	quick-xml@0.31.0
	quote@1.0.36
	regex-automata@0.4.6
	regex-syntax@0.8.3
	regex@1.10.4
	relative-path@1.9.3
	ron@0.8.1
	rstest@0.19.0
	rstest_macros@0.19.0
	rustc_version@0.4.0
	rustix@0.38.34
	scoped-tls@1.0.1
	semver@1.0.23
	serde@1.0.201
	serde_derive@1.0.201
	slab@0.4.9
	smallvec@1.10.0
	snafu-derive@0.7.5
	snafu@0.7.5
	strsim@0.10.0
	syn@1.0.109
	syn@2.0.61
	termcolor@1.4.1
	thiserror-impl@1.0.60
	thiserror@1.0.60
	toml@0.5.11
	tracing-core@0.1.32
	tracing@0.1.40
	unicode-ident@1.0.12
	utf8parse@0.2.1
	wayland-backend@0.3.3
	wayland-client@0.31.2
	wayland-protocols-wlr@0.2.0
	wayland-protocols@0.31.2
	wayland-scanner@0.31.1
	wayland-sys@0.31.1
	winapi-util@0.1.8
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	xdg@2.5.2
"

inherit cargo

DESCRIPTION="A wayland dynamic output config tool focusing on accuracy and determinism"
HOMEPAGE="https://gitlab.com/w0lff/shikane"

SRC_URI="
	https://gitlab.com/w0lff/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+man"

BDEPEND="
	man? ( virtual/pandoc sys-apps/sed )
"

# Crates handle pretty much all dependencies,
# final binary only depends on stdlib
#DEPEND="dev-libs/wayland-protocols"

src_prepare() {
	default

	# remove call to compress man pages, portage does this independently
	use man && sed -ie '/^\s*gzip -9 -f "$out\/$page"/d' "${S}/scripts/build-docs.sh"
}

src_compile() {
	cargo_src_compile

	if use man ; then
		einfo "Building man pages..."
		bash "${S}/scripts/build-docs.sh" man
	fi
}

src_install() {
	cargo_src_install

	if use man ; then
		doman "${S}/build/man/shikane.1"
		doman "${S}/build/man/shikane.5"
		doman "${S}/build/man/shikanectl.1"
	fi
}
