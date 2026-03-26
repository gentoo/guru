# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

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
	libc@0.2.183
	memchr@2.8.0
	memoffset@0.9.1
	once_cell@1.21.4
	portable-atomic@1.13.1
	proc-macro2@1.0.106
	pyo3-build-config@0.26.0
	pyo3-ffi@0.26.0
	pyo3-macros-backend@0.26.0
	pyo3-macros@0.26.0
	pyo3@0.26.0
	quote@1.0.45
	regex-automata@0.4.14
	regex-syntax@0.8.10
	regex@1.12.3
	rustc-hash@2.1.1
	rustversion@1.0.22
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	syn@2.0.117
	target-lexicon@0.13.5
	unicode-ident@1.0.24
	unindent@0.2.4
"

inherit cargo distutils-r1 optfeature pypi

DESCRIPTION="A fast BPE tokeniser for use with OpenAI's models"
HOMEPAGE="
	https://github.com/openai/tiktoken
	https://pypi.org/project/tiktoken/
"
TTE_TAG=2026.03.26.0
TTE_BASE_URI="https://github.com/falbrechtskirchinger/overlay-assets/releases/download"
SRC_URI+="
	${CARGO_CRATE_URIS}
	test? (
		${TTE_BASE_URI}/v${TTE_TAG}/tiktoken-encodings-v${TTE_TAG%.*}.tar.xz
	)
"
# The encodings cache (tiktoken-encodings-*.tar.xz) holds files named after
# the SHA-1 of their URL. It can be generated from the source directory via:
# grep -Eo 'https://openaipublic.blob[^"]+' tiktoken_ext/openai_public.py | \
# sort -u | while read u; do h=$(echo -n "$u" | sha1sum | awk '{print $1}'); \
# wget -O "$h" "$u" ; done
# Include the license file from the source repo:
# https://github.com/openai/tiktoken/issues/92

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/blobfile[${PYTHON_USEDEP}]
	)
"

PATCHES=(
	# test_encoding.py::test_hyp_roundtrip throws ValueError for special tokens
	"${FILESDIR}/tiktoken-0.12.0-special-token-roudtrip.patch"
)

EPYTEST_PLUGINS=(
	hypothesis
	pytest-{asyncio,timeout}
)
distutils_enable_tests pytest

python_test() {
	local -x PATH=${BUILD_DIR}/install/usr/bin:${PATH}
	local -x TIKTOKEN_CACHE_DIR="${WORKDIR}/tiktoken-encodings"

	rm -rf tiktoken || die

	epytest
}

pkg_postinst() {
	optfeature "reading GCS, ABS files" dev-python/blobfile
}
