# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{10..12} )

CRATES="
	aho-corasick@1.1.2
	autocfg@1.1.0
	bindgen@0.69.1
	bitflags@1.3.2
	bitflags@2.4.1
	cc@1.0.83
	cexpr@0.6.0
	cfg-if@1.0.0
	clang-sys@1.6.1
	cmake@0.1.50
	either@1.9.0
	errno@0.3.8
	foreign-types@0.5.0
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	glob@0.3.1
	home@0.5.5
	indoc@1.0.9
	lazy_static@1.4.0
	lazycell@1.3.0
	libc@0.2.151
	libloading@0.7.4
	linux-raw-sys@0.4.12
	lock_api@0.4.11
	log@0.4.20
	memchr@2.6.4
	memoffset@0.8.0
	minimal-lexical@0.2.1
	nom@7.1.3
	once_cell@1.19.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	peeking_take_while@0.1.2
	prettyplease@0.2.15
	proc-macro2@1.0.70
	pyo3@0.18.3
	pyo3-build-config@0.18.3
	pyo3-ffi@0.18.3
	pyo3-macros@0.18.3
	pyo3-macros-backend@0.18.3
	quote@1.0.33
	redox_syscall@0.4.1
	regex@1.10.2
	regex-automata@0.4.3
	regex-syntax@0.8.2
	rustc-hash@1.1.0
	rustix@0.38.28
	scopeguard@1.2.0
	shlex@1.2.0
	smallvec@1.11.2
	syn@1.0.109
	syn@2.0.40
	target-lexicon@0.12.12
	thiserror@1.0.50
	thiserror-impl@1.0.50
	unicode-ident@1.0.12
	unindent@0.1.11
	which@4.4.2
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.0
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.0
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.0
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.0
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.0
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.0
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.0
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.0
"

inherit cargo distutils-r1

DESCRIPTION="An opinionated Python binding for Hyperscan"
HOMEPAGE="https://github.com/vlaci/pyperscan https://vlaci.github.io/pyperscan/"

SRC_URI="https://github.com/vlaci/pyperscan/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="MIT"
LICENSE+=" Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD ISC Unicode-DFS-2016 Unlicense"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

distutils_enable_tests pytest
