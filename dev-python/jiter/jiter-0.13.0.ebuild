# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=( maturin crates/jiter-python )
PYPI_VERIFY_REPO=https://github.com/pydantic/jiter
PYTHON_COMPAT=( python3_{11..14} )

RUST_MIN_VER="1.87.0"
CRATES="
	ahash@0.8.12
	aho-corasick@1.1.4
	anes@0.1.6
	anstyle@1.0.13
	arbitrary@1.4.2
	autocfg@1.5.0
	bitvec@1.0.1
	bumpalo@3.19.1
	cast@0.3.0
	cc@1.2.55
	cfg-if@1.0.4
	ciborium-io@0.2.2
	ciborium-ll@0.2.2
	ciborium@0.2.2
	clap@4.5.56
	clap_builder@4.5.56
	clap_lex@0.7.7
	codspeed-criterion-compat-walltime@2.10.1
	codspeed-criterion-compat@2.10.1
	codspeed@2.10.1
	colored@2.2.0
	criterion-plot@0.5.0
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crunchy@0.2.4
	either@1.15.0
	equivalent@1.0.2
	find-msvc-tools@0.1.9
	funty@2.0.0
	getrandom@0.3.4
	half@2.7.1
	hashbrown@0.16.1
	heck@0.5.0
	hermit-abi@0.5.2
	indexmap@2.13.0
	is-terminal@0.4.17
	itertools@0.10.5
	itoa@1.0.17
	jobserver@0.1.34
	js-sys@0.3.85
	lazy_static@1.5.0
	lexical-parse-float@1.0.6
	lexical-parse-integer@1.0.6
	lexical-util@1.0.7
	libc@0.2.180
	libfuzzer-sys@0.4.10
	memchr@2.7.6
	num-bigint@0.4.6
	num-integer@0.1.46
	num-traits@0.2.19
	once_cell@1.21.3
	oorandom@11.1.5
	paste@1.0.15
	plotters-backend@0.3.7
	plotters-svg@0.3.7
	plotters@0.3.7
	portable-atomic@1.13.1
	proc-macro2@1.0.106
	pyo3-build-config@0.28.0
	pyo3-ffi@0.28.0
	pyo3-macros-backend@0.28.0
	pyo3-macros@0.28.0
	pyo3@0.28.0
	python3-dll-a@0.2.14
	quote@1.0.44
	r-efi@5.3.0
	radium@0.7.0
	rayon-core@1.13.0
	rayon@1.11.0
	regex-automata@0.4.13
	regex-syntax@0.8.8
	regex@1.12.2
	rustversion@1.0.22
	same-file@1.0.6
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.149
	shlex@1.3.0
	smallvec@1.15.1
	syn@2.0.114
	tap@1.0.1
	target-lexicon@0.13.4
	tinytemplate@1.2.1
	unicode-ident@1.0.22
	uuid@1.20.0
	version_check@0.9.5
	walkdir@2.5.0
	wasip2@1.0.2+wasi-0.2.9
	wasm-bindgen-macro-support@0.2.108
	wasm-bindgen-macro@0.2.108
	wasm-bindgen-shared@0.2.108
	wasm-bindgen@0.2.108
	web-sys@0.3.85
	winapi-util@0.1.11
	windows-link@0.2.1
	windows-sys@0.59.0
	windows-sys@0.61.2
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	wit-bindgen@0.51.0
	wyz@0.5.1
	zerocopy-derive@0.8.37
	zerocopy@0.8.37
	zmij@1.0.19
"

inherit cargo distutils-r1 pypi

DESCRIPTION="Fast iterable JSON parser"
HOMEPAGE="
	https://github.com/pydantic/jiter
	https://pypi.org/project/jiter/
"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT MPL-2.0 UoI-NCSA
	Unicode-3.0
"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/jiter/jiter.*.so"

EPYTEST_PLUGINS=( dirty-equals )
distutils_enable_tests pytest

src_unpack() {
	# Required for verify-provenance
	pypi_src_unpack
	cargo_src_unpack
}
