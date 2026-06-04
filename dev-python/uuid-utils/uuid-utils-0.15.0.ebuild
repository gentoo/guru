# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ahash@0.8.12
	anyhow@1.0.102
	atomic@0.6.1
	autocfg@1.5.0
	bitflags@2.5.0
	block-buffer@0.10.4
	bumpalo@3.19.0
	bytemuck@1.23.2
	cc@1.0.83
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	chacha20@0.10.0
	cpufeatures@0.3.0
	crypto-common@0.1.6
	digest@0.10.7
	equivalent@1.0.2
	foldhash@0.1.5
	generic-array@0.14.7
	getrandom@0.3.2
	getrandom@0.4.1
	hashbrown@0.15.5
	hashbrown@0.16.1
	heck@0.5.0
	id-arena@2.3.0
	indexmap@2.13.0
	itoa@1.0.17
	js-sys@0.3.77
	leb128fmt@0.1.0
	libc@0.2.171
	log@0.4.27
	mac_address@1.1.8
	md-5@0.10.6
	memchr@2.8.0
	memoffset@0.9.1
	nix@0.29.0
	once_cell@1.21.3
	portable-atomic@1.6.0
	prettyplease@0.2.37
	proc-macro2@1.0.106
	pyo3-build-config@0.28.3
	pyo3-ffi@0.28.3
	pyo3-macros-backend@0.28.3
	pyo3-macros@0.28.3
	pyo3@0.28.3
	python3-dll-a@0.2.15
	quote@1.0.44
	r-efi@5.2.0
	rand@0.10.1
	rand_core@0.10.0
	semver@1.0.27
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.149
	sha1_smol@1.0.1
	syn@2.0.117
	target-lexicon@0.13.5
	typenum@1.18.0
	unicode-ident@1.0.12
	unicode-xid@0.2.6
	uuid@1.23.1
	version_check@0.9.4
	wasi@0.14.2+wasi-0.2.4
	wasip2@1.0.2+wasi-0.2.9
	wasip3@0.4.0+wasi-0.3.0-rc-2026-01-06
	wasm-bindgen-backend@0.2.100
	wasm-bindgen-macro-support@0.2.100
	wasm-bindgen-macro@0.2.100
	wasm-bindgen-shared@0.2.100
	wasm-bindgen@0.2.100
	wasm-encoder@0.244.0
	wasm-metadata@0.244.0
	wasmparser@0.244.0
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	wit-bindgen-core@0.51.0
	wit-bindgen-rt@0.39.0
	wit-bindgen-rust-macro@0.51.0
	wit-bindgen-rust@0.51.0
	wit-bindgen@0.51.0
	wit-component@0.244.0
	wit-parser@0.244.0
	zerocopy-derive@0.8.26
	zerocopy@0.8.26
	zmij@1.0.21
"
RUST_MIN_VER="1.87.0"

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{12..15} )
inherit cargo distutils-r1 pypi

DESCRIPTION="Fast, drop-in replacement for Python's uuid module, powered by Rust."
HOMEPAGE="
	https://aminalaee.github.io/uuid-utils/
	https://github.com/aminalaee/uuid-utils
	https://pypi.org/project/uuid_utils/
"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="BSD"
# Dependent crate licenses
LICENSE+="
	Apache-2.0-with-LLVM-exceptions BSD MIT Unicode-DFS-2016 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="/usr/lib/python.*/site-packages/uuid_utils/.*.so"

EPYTEST_PLUGINS=()
EPYTEST_DESELECT=(
	# Network sandbox probably messes with it
	# https://github.com/aminalaee/uuid-utils/issues/99#issuecomment-3666565390
	tests/test_uuid.py::test_getnode
)
EPYTEST_IGNORE=(
	# Benchmarking doesn't make sense in an ebuild
	tests/test_benchmarks.py
)
distutils_enable_tests pytest
