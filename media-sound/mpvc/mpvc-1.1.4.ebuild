# Copyright 2017-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.10

EAPI=8

CRATES="
	atty@0.2.14
	autocfg@1.1.0
	bitflags@1.3.2
	bitflags@2.3.3
	cc@1.0.81
	clap@3.2.25
	clap_lex@0.2.4
	colored@2.0.4
	errno-dragonfly@0.1.2
	errno@0.3.2
	hashbrown@0.12.3
	hermit-abi@0.1.19
	hermit-abi@0.3.2
	indexmap@1.9.3
	is-terminal@0.4.9
	itoa@1.0.9
	lazy_static@1.4.0
	libc@0.2.147
	linux-raw-sys@0.4.5
	log@0.4.19
	mpvipc@1.3.0
	os_str_bytes@6.5.1
	rustix@0.38.6
	ryu@1.0.15
	serde@1.0.181
	serde_json@1.0.104
	strsim@0.10.0
	termcolor@1.2.0
	textwrap@0.16.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.5
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-targets@0.48.1
	windows_aarch64_gnullvm@0.48.0
	windows_aarch64_msvc@0.48.0
	windows_i686_gnu@0.48.0
	windows_i686_msvc@0.48.0
	windows_x86_64_gnu@0.48.0
	windows_x86_64_gnullvm@0.48.0
	windows_x86_64_msvc@0.48.0
"

inherit cargo

DESCRIPTION="mpc-like tool which connects to existing mpv instances through sockets."
HOMEPAGE="https://gitlab.com/mpv-ipc/mpvc"
SRC_URI="
$(cargo_crate_uris ${CRATES})
https://gitlab.com/mpv-ipc/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2
"

S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3+"
LICENSE+="
	GPL-3 MIT MPL-2.0
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

DEPEND="media-video/mpv"
RDEPEND="${DEPEND}"
BDEPEND="virtual/rust"

QA_FLAGS_IGNORED="usr/bin/mpvc"
