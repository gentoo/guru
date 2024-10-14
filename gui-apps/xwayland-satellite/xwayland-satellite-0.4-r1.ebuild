# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.3
	anstream@0.6.14
	anstyle-parse@0.2.4
	anstyle-query@1.1.0
	anstyle-wincon@3.0.3
	anstyle@1.0.7
	bindgen@0.69.4
	bitflags@1.3.2
	bitflags@2.5.0
	cc@1.0.99
	cexpr@0.6.0
	cfg-if@1.0.0
	clang-sys@1.8.1
	colorchoice@1.0.1
	cursor-icon@1.1.0
	dlib@0.5.2
	downcast-rs@1.2.1
	either@1.12.0
	env_filter@0.1.0
	env_logger@0.10.2
	env_logger@0.11.3
	errno@0.3.9
	glob@0.3.1
	hermit-abi@0.3.9
	home@0.5.9
	humantime@2.1.0
	io-lifetimes@2.0.3
	is-terminal@0.4.12
	is_terminal_polyfill@1.70.0
	itertools@0.12.1
	lazy_static@1.4.0
	lazycell@1.3.0
	libc@0.2.155
	libloading@0.8.3
	linux-raw-sys@0.4.14
	log@0.4.21
	memchr@2.7.2
	memmap2@0.9.4
	minimal-lexical@0.2.1
	nom@7.1.3
	once_cell@1.19.0
	paste@1.0.15
	pkg-config@0.3.30
	pretty_env_logger@0.5.0
	prettyplease@0.2.20
	proc-macro2@1.0.85
	quick-xml@0.30.0
	quick-xml@0.31.0
	quote@1.0.36
	regex-automata@0.4.7
	regex-syntax@0.8.4
	regex@1.10.5
	rustc-hash@1.1.0
	rustix@0.38.34
	scoped-tls@1.0.1
	shlex@1.3.0
	slotmap@1.0.7
	smallvec@1.13.2
	smithay-client-toolkit@0.19.1
	syn@2.0.66
	termcolor@1.4.1
	thiserror-impl@1.0.61
	thiserror@1.0.61
	unicode-ident@1.0.12
	utf8parse@0.2.2
	version_check@0.9.4
	wayland-backend@0.3.4
	wayland-client@0.31.3
	wayland-csd-frame@0.3.0
	wayland-cursor@0.31.3
	wayland-protocols-wlr@0.3.1
	wayland-protocols@0.31.2
	wayland-protocols@0.32.1
	wayland-scanner@0.31.2
	wayland-server@0.31.2
	wayland-sys@0.31.2
	which@4.4.2
	winapi-util@0.1.8
	windows-sys@0.52.0
	windows-targets@0.52.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.52.5
	xcb-util-cursor-sys@0.1.4
	xcb-util-cursor@0.3.3
	xcb@1.4.0
	xcursor@0.3.5
	xkeysym@0.2.1
"

LLVM_COMPAT=( {17..19} )

inherit cargo llvm-r1

DESCRIPTION="Xwayland outside your Wayland"
HOMEPAGE="https://github.com/Supreeeme/xwayland-satellite"
SRC_URI="
	https://github.com/Supreeeme/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MPL-2.0"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD ISC MIT Unicode-DFS-2016 ZLIB"
SLOT="0"
KEYWORDS="~amd64"

# disable tests which need a running display server
RESTRICT="test"

DEPEND="
	>=x11-base/xwayland-23.1
	x11-libs/libxcb
	x11-libs/xcb-util-cursor
"
RDEPEND="${DEPEND}"
BDEPEND="
	$(llvm_gen_dep 'sys-devel/clang:${LLVM_SLOT}=')
"

QA_FLAGS_IGNORED="usr/bin/${PN}"

DOCS=( README.md )

src_install() {
	cargo_src_install
	einstalldocs
}
