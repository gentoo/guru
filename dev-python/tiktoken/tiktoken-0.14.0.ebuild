# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

RUST_MIN_VER="1.85.0"
# Bump PyO3 to 0.29.0 (RUSTSEC-2026-0176, RUSTSEC-2026-0177)
CRATES="
	pyo3-build-config@0.29.0
	pyo3-ffi@0.29.0
	pyo3-macros-backend@0.29.0
	pyo3-macros@0.29.0
	pyo3@0.29.0
"

inherit cargo distutils-r1 optfeature

# The encodings cache (tiktoken-encodings-*.tar.xz) holds files named after
# the SHA-1 of their URL. It can be generated from the source directory via:
# grep -Eo 'https://openaipublic.blob[^"]+' tiktoken_ext/openai_public.py | \
# sort -u | while read u; do h=$(echo -n "$u" | sha1sum | awk '{print $1}'); \
# wget -O "$h" "$u" ; done
# Include the license file from the source repo:
# https://github.com/openai/tiktoken/issues/92
TTE_TAG=2026.03.26.0
TTE_BASE_URI="https://github.com/falbrechtskirchinger/overlay-assets/releases/download"

DESCRIPTION="A fast BPE tokeniser for use with OpenAI's models"
HOMEPAGE="
	https://github.com/openai/tiktoken
	https://pypi.org/project/tiktoken/
"
SRC_URI="
	https://github.com/openai/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/fasys-crate-dist/${PN}/releases/download/${PV}/${P}-crates.tar.xz
	${CARGO_CRATE_URIS}
	test? (
		${TTE_BASE_URI}/v${TTE_TAG}/tiktoken-encodings-v${TTE_TAG%.*}.tar.xz
	)
"

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
	dev-python/setuptools-rust[${PYTHON_USEDEP}]
	test? (
		dev-python/blobfile[${PYTHON_USEDEP}]
	)
"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/tiktoken/_tiktoken.*\.so"

PATCHES=(
	# test_encoding.py::test_hyp_roundtrip throws ValueError for special tokens
	"${FILESDIR}/tiktoken-0.13.0-special-token-roudtrip.patch"
)

EPYTEST_PLUGINS=(
	hypothesis
	pytest-{asyncio,timeout}
)
distutils_enable_tests pytest

src_prepare() {
	distutils-r1_src_prepare
	sed '/^pyo3 =/s/version = "0\.28\.3"/version = "0.29.0"/' -i Cargo.toml || die
}

python_test() {
	local -x PATH=${BUILD_DIR}/install/usr/bin:${PATH}
	local -x TIKTOKEN_CACHE_DIR="${WORKDIR}/tiktoken-encodings"

	rm -rf tiktoken || die

	epytest
}

pkg_postinst() {
	optfeature "reading GCS, ABS files" dev-python/blobfile
}
