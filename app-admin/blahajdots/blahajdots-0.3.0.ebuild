# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.3
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	autocfg@1.3.0
	bitflags@2.6.0
	block-buffer@0.10.4
	byteorder@1.5.0
	cfg-expr@0.16.0
	cfg-if@1.0.0
	clap-verbosity-flag@2.2.1
	clap@4.5.18
	clap_builder@4.5.18
	clap_derive@4.5.18
	clap_lex@0.7.2
	colorchoice@1.0.2
	cpufeatures@0.2.14
	crypto-common@0.1.6
	digest@0.10.7
	env_filter@0.1.2
	env_logger@0.11.5
	equivalent@1.0.1
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-macro@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	generic-array@0.14.7
	getrandom@0.2.15
	gio-sys@0.20.1
	gio@0.20.1
	glib-macros@0.20.3
	glib-sys@0.20.2
	glib@0.20.3
	glob@0.3.1
	gobject-sys@0.20.1
	handlebars@6.1.0
	hashbrown@0.14.5
	heck@0.5.0
	home@0.5.9
	humantime@2.1.0
	indexmap@2.5.0
	is_terminal_polyfill@1.70.1
	itoa@1.0.11
	libc@0.2.158
	log@0.4.22
	memchr@2.7.4
	once_cell@1.19.0
	pest@2.7.13
	pest_derive@2.7.13
	pest_generator@2.7.13
	pest_meta@2.7.13
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	pkg-config@0.3.30
	ppv-lite86@0.2.20
	proc-macro-crate@3.2.0
	proc-macro2@1.0.86
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	regex-automata@0.4.7
	regex-syntax@0.8.4
	regex@1.10.6
	ryu@1.0.18
	same-file@1.0.6
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.128
	serde_spanned@0.6.7
	sha2@0.10.8
	slab@0.4.9
	smallvec@1.13.2
	strsim@0.11.1
	syn@2.0.77
	system-deps@7.0.2
	target-lexicon@0.12.16
	thiserror-impl@1.0.63
	thiserror@1.0.63
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.21
	typenum@1.17.0
	ucd-trie@0.1.6
	unicode-ident@1.0.13
	untildify@0.1.1
	utf8parse@0.2.2
	version-compare@0.2.0
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	winapi-util@0.1.9
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.6.18
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
"

inherit cargo

DESCRIPTION="Bespoke dotfile management for sharkgirls."
HOMEPAGE="https://codeberg.org/vimproved/blahajdots"

if [[ "${PV}" = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/vimproved/blahajdots.git"
else
	SRC_URI="https://codeberg.org/vimproved/blahajdots/archive/v${PV}.tar.gz -> ${P}.tar.gz
		${CARGO_CRATE_URIS}"
	S="${WORKDIR}/${PN}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
	Apache-2.0-with-LLVM-exceptions MIT Unicode-DFS-2016
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"
IUSE="+gsettings"

DEPEND="gsettings? ( dev-libs/glib:2= )"
RDEPEND="${DEPEND}"

QA_FLAGS_IGNORED="usr/bin/blahaj"

src_unpack() {
	if [[ "${PV}" = "9999" ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_configure() {
	local myfeatures=(
		$(usev gsettings)
	)

	cargo_src_configure --no-default-features
}
