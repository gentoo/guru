# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

CRATES="
	aho-corasick@1.1.4
	base64@0.22.1
	bitflags@2.13.0
	bstr@1.12.3
	bumpalo@3.20.3
	cc@1.2.67
	cfg-if@1.0.4
	colored@3.1.1
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	dirs-sys@0.5.0
	dirs@6.0.0
	either@1.16.0
	equivalent@1.0.2
	fallible-iterator@0.3.0
	fallible-streaming-iterator@0.1.9
	find-msvc-tools@0.1.9
	foldhash@0.2.0
	getrandom@0.2.17
	globset@0.4.18
	hashbrown@0.16.1
	hashbrown@0.17.1
	hashlink@0.12.1
	heck@0.5.0
	ignore@0.4.26
	indexmap@2.14.0
	js-sys@0.3.103
	libc@0.2.186
	libredox@0.1.18
	libsqlite3-sys@0.38.1
	log@0.4.33
	memchr@2.8.2
	memmap2@0.9.11
	once_cell@1.21.4
	option-ext@0.2.0
	pkg-config@0.3.33
	portable-atomic@1.13.1
	proc-macro2@1.0.106
	pyo3-build-config@0.29.0
	pyo3-ffi@0.29.0
	pyo3-macros-backend@0.29.0
	pyo3-macros@0.29.0
	pyo3@0.29.0
	quote@1.0.45
	rayon-core@1.13.0
	rayon@1.12.0
	redox_users@0.5.2
	regex-automata@0.4.14
	regex-syntax@0.8.11
	regex@1.12.4
	rsqlite-vfs@0.1.1
	rusqlite@0.40.1
	rust-yaml@1.1.0
	rustversion@1.0.23
	same-file@1.0.6
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	shlex@2.0.1
	similar@3.1.1
	smallvec@1.15.2
	sqlite-wasm-rs@0.5.5
	syn@2.0.118
	target-lexicon@0.13.5
	thiserror-impl@2.0.18
	thiserror@2.0.18
	unicode-ident@1.0.24
	vcpkg@0.2.15
	walkdir@2.5.0
	wasi@0.11.1+wasi-snapshot-preview1
	wasm-bindgen-macro-support@0.2.126
	wasm-bindgen-macro@0.2.126
	wasm-bindgen-shared@0.2.126
	wasm-bindgen@0.2.126
	winapi-util@0.1.11
	windows-link@0.2.1
	windows-sys@0.61.2
	xxhash-rust@0.8.16
"

RUST_MIN_VER="1.85.0"

inherit cargo distutils-r1

DESCRIPTION="A formatter to make your CMake code the real treasure"
HOMEPAGE="https://github.com/BlankSpruce/gersemi"
SRC_URI="
	https://github.com/BlankSpruce/gersemi/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MPL-2.0"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions Boost-1.0 MIT MPL-2.0
	Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/lark[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
BDEPEND="
	${RUST_DEPEND}
	dev-python/setuptools-rust[${PYTHON_USEDEP}]

	test? (
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-vcs/git
	)
"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/gersemi.*.so"

EPYTEST_PLUGINS=()

distutils_enable_tests pytest

src_unpack() {
	cargo_src_unpack
}
