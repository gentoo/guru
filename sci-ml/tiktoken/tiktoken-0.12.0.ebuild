# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

RUST_MIN_VER="1.85.0"
CRATES="
	aho-corasick@1.1.4
	autocfg@1.5.0
	bit-set@0.5.3
	bit-vec@0.6.3
	bstr@1.12.1
	fancy-regex@0.13.0
	heck@0.5.0
	indoc@2.0.7
	libc@0.2.177
	memchr@2.7.6
	memoffset@0.9.1
	once_cell@1.21.3
	portable-atomic@1.11.1
	proc-macro2@1.0.103
	pyo3-build-config@0.26.0
	pyo3-ffi@0.26.0
	pyo3-macros-backend@0.26.0
	pyo3-macros@0.26.0
	pyo3@0.26.0
	quote@1.0.42
	regex-automata@0.4.13
	regex-syntax@0.8.8
	regex@1.12.2
	rustc-hash@2.1.1
	rustversion@1.0.22
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	syn@2.0.110
	target-lexicon@0.13.3
	unicode-ident@1.0.22
	unindent@0.2.4
"

inherit cargo distutils-r1 pypi

DESCRIPTION="A fast BPE tokeniser for use with OpenAI's models"
HOMEPAGE="
	https://pypi.org/project/tiktoken/
	https://github.com/openai/tiktoken/
"

SRC_URI+="
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
LICENSE+="
	Apache-2.0-with-LLVM-exceptions Unicode-3.0
"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_PLUGINS=( hypothesis )

DEPEND="
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-python/setuptools-rust[${PYTHON_USEDEP}]
"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/tiktoken/_tiktoken.*.so"

# Tests require network connection
RESTRICT="test"
PROPERTIES="test_network"

distutils_enable_tests pytest

src_unpack() {
	cargo_src_unpack
}

python_test() {
	rm -rf tiktoken tiktoken_ext || die
	epytest
}
