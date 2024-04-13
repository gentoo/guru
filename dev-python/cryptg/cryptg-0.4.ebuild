# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	aes@0.7.5
	autocfg@1.1.0
	base64ct@1.5.3
	bitflags@1.3.2
	block-buffer@0.9.0
	cfg-if@1.0.0
	cipher@0.3.0
	core2@0.4.0
	cpufeatures@0.2.5
	crypto-mac@0.11.1
	digest@0.9.0
	generic-array@0.14.6
	getrandom@0.2.8
	glass_pumpkin@1.3.0
	grammers-crypto@0.4.0
	hmac@0.11.0
	indoc@1.0.7
	lazy_static@1.4.0
	libc@0.2.137
	lock_api@0.4.9
	memchr@2.5.0
	memoffset@0.6.5
	num-bigint@0.4.3
	num-integer@0.1.45
	num-traits@0.2.15
	once_cell@1.15.0
	opaque-debug@0.3.0
	parking_lot@0.12.1
	parking_lot_core@0.9.4
	password-hash@0.2.3
	pbkdf2@0.8.0
	ppv-lite86@0.2.16
	proc-macro2@1.0.47
	pyo3@0.17.2
	pyo3-build-config@0.17.2
	pyo3-ffi@0.17.2
	pyo3-macros@0.17.2
	pyo3-macros-backend@0.17.2
	quote@1.0.21
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.2.16
	scopeguard@1.1.0
	sha1@0.6.1
	sha1_smol@1.0.0
	sha2@0.9.9
	smallvec@1.10.0
	subtle@2.4.1
	syn@1.0.103
	target-lexicon@0.12.4
	typenum@1.15.0
	unicode-ident@1.0.5
	unindent@0.1.10
	version_check@0.9.4
	wasi@0.11.0+wasi-snapshot-preview1
	windows-sys@0.42.0
	windows_aarch64_gnullvm@0.42.0
	windows_aarch64_msvc@0.42.0
	windows_i686_gnu@0.42.0
	windows_i686_msvc@0.42.0
	windows_x86_64_gnu@0.42.0
	windows_x86_64_gnullvm@0.42.0
	windows_x86_64_msvc@0.42.0
"
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit cargo distutils-r1

DESCRIPTION="Hachoir is a Python library to view and edit a binary stream field by field "
HOMEPAGE="https://github.com/cher-nov/cryptg/"
SRC_URI="https://github.com/cher-nov/cryptg/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CC0-1.0 MIT Unicode-DFS-2016 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-python/setuptools-rust"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/lib/python3\..*/site-packages/cryptg/cryptg.cpython-.*.so"
