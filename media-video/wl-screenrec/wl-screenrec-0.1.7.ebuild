# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aho-corasick@1.1.3
	anstream@0.6.18
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.7
	anstyle@1.0.10
	anyhow@1.0.97
	bindgen@0.70.1
	bitflags@2.9.0
	bytemuck@1.22.0
	bytemuck_derive@1.9.2
	cc@1.2.17
	cexpr@0.6.0
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	clang-sys@1.8.1
	clap@4.5.32
	clap_builder@4.5.32
	clap_complete@4.5.47
	clap_derive@4.5.32
	clap_lex@0.7.4
	colorchoice@1.0.3
	deranged@0.4.0
	downcast-rs@1.2.1
	drm-ffi@0.9.0
	drm-fourcc@2.2.0
	drm-sys@0.8.0
	drm@0.14.1
	either@1.15.0
	errno@0.3.10
	ffmpeg-next@7.1.0
	ffmpeg-sys-next@7.1.0
	glob@0.3.2
	heck@0.5.0
	hermit-abi@0.3.9
	human-size@0.4.3
	is_terminal_polyfill@1.70.1
	itertools@0.13.0
	itoa@1.0.15
	libc@0.2.171
	libloading@0.8.6
	linux-raw-sys@0.4.15
	linux-raw-sys@0.6.5
	log-once@0.4.1
	log@0.4.26
	memchr@2.7.4
	minimal-lexical@0.2.1
	nix@0.29.0
	nom@7.1.3
	num-conv@0.1.0
	num_cpus@1.16.0
	num_threads@0.1.7
	once_cell@1.21.1
	pkg-config@0.3.32
	powerfmt@0.2.0
	proc-macro2@1.0.94
	quick-xml@0.37.2
	quote@1.0.40
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rustc-hash@1.1.0
	rustix@0.38.44
	ryu@1.0.20
	serde@1.0.219
	serde_derive@1.0.219
	serde_json@1.0.140
	shlex@1.3.0
	signal-hook-registry@1.4.2
	signal-hook@0.3.17
	simplelog@0.12.2
	smallvec@1.14.0
	strsim@0.11.1
	syn@2.0.100
	termcolor@1.4.1
	thiserror-impl@2.0.12
	thiserror@2.0.12
	time-core@0.1.4
	time-macros@0.2.21
	time@0.3.40
	unicode-ident@1.0.18
	utf8parse@0.2.2
	vcpkg@0.2.15
	wayland-backend@0.3.8
	wayland-client@0.31.8
	wayland-protocols-wlr@0.3.6
	wayland-protocols@0.32.6
	wayland-scanner@0.31.6
	wayland-sys@0.31.6
	winapi-util@0.1.9
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
"

LLVM_COMPAT=( {16..19} )
RUST_NEEDS_LLVM=1

inherit cargo shell-completion llvm-r1

DESCRIPTION="High performance screen/audio recorder for wlroots"
HOMEPAGE="https://github.com/russelltg/wl-screenrec"
SRC_URI="
	https://github.com/russelltg/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="Apache-2.0 BSD ISC MIT Unicode-3.0 WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"
# We need a running Wayland compositor for the tests to work
RESTRICT="test"

BDEPEND="
	$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}
	')
"
RDEPEND="
	media-video/ffmpeg:=[vaapi]
	x11-libs/libdrm
"
DEPEND="
	${RDEPEND}
"

QA_FLAGS_IGNORED="usr/bin/${PN}"

pkg_setup() {
	llvm-r1_pkg_setup
	rust_pkg_setup
}

src_compile() {
	cargo_src_compile

	./"$(cargo_target_dir)/${PN}" --generate-completions bash > "${S}/wl-screenrec" || \
		die "Could not generate bash completion"
	./"$(cargo_target_dir)/${PN}" --generate-completions fish > "${S}/wl-screenrec.fish" || \
		die "Could not generate fish completion"
	./"$(cargo_target_dir)/${PN}" --generate-completions zsh > "${S}/_wl-screenrec" || \
		die "Could not generate zsh completion"
}

src_install() {
	cargo_src_install

	dobashcomp "${S}/wl-screenrec" || die "Could not install bash completion"
	dofishcomp "${S}/wl-screenrec.fish" || die "Could not install fish completion"
	dozshcomp "${S}/_wl-screenrec" || die "Could not install zsh completion"
}

pkg_postinst() {
	elog "You need a wayland compositor that supports the"
	elog "following unstable protocols:"
	elog "  - wlr-output-management-unstable-v1"
	elog "  - wlr-screencopy-unstable-v1"
	elog "You should also make sure you have the correct librairies"
	elog "installed. See: https://trac.ffmpeg.org/wiki/Hardware/VAAPI"
}
