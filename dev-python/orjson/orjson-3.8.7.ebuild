# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
CRATES="
	ahash-0.8.3
	arrayvec-0.7.2
	associative-cache-1.0.1
	autocfg-1.1.0
	beef-0.5.2
	bytecount-0.6.3
	castaway-0.2.2
	cc-1.0.79
	cfg-if-1.0.0
	chrono-0.4.23
	compact_str-0.6.1
	encoding_rs-0.8.32
	itoa-1.0.5
	itoap-1.0.1
	libc-0.2.139
	libm-0.1.4
	num-integer-0.1.45
	num-traits-0.2.15
	once_cell-1.17.1
	packed_simd_2-0.3.8
	pyo3-build-config-0.18.1
	pyo3-ffi-0.18.1
	rustversion-1.0.11
	ryu-1.0.12
	serde-1.0.152
	serde_json-1.0.93
	simdutf8-0.1.4
	smallvec-1.10.0
	target-lexicon-0.12.6
	version_check-0.9.4
"

DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{9..11} )
inherit cargo distutils-r1 pypi

DESCRIPTION="Fast, correct Python JSON library supporting dataclasses, datetimes, and numpy"
HOMEPAGE="
	https://pypi.org/project/orjson/
	https://github.com/ijl/orjson
"
SRC_URI="
	$(pypi_sdist_url)
	$(cargo_crate_uris)
"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+=" Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD MIT"
KEYWORDS="~amd64"
SLOT="0"
IUSE="debug"

BDEPEND="
	test? (
		dev-python/arrow[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pendulum[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
	)
"

QA_FLAGS_IGNORED=".*"

distutils_enable_tests pytest

src_unpack() {
	cargo_src_unpack
}
