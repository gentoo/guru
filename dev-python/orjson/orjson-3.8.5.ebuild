# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
CRATES="
	ahash-0.8.2
	arrayvec-0.7.2
	associative-cache-1.0.1
	autocfg-1.1.0
	beef-0.5.2
	bytecount-0.6.3
	castaway-0.2.2
	cc-1.0.78
	cfg-if-1.0.0
	chrono-0.4.23
	compact_str-0.6.1
	encoding_rs-0.8.31
	itoa-1.0.5
	itoap-1.0.1
	libc-0.2.139
	libm-0.1.4
	num-integer-0.1.45
	num-traits-0.2.15
	once_cell-1.17.0
	packed_simd_2-0.3.8
	pyo3-build-config-0.17.3
	pyo3-ffi-0.17.3
	rustversion-1.0.11
	ryu-1.0.12
	serde-1.0.152
	serde_json-1.0.91
	simdutf8-0.1.4
	smallvec-1.10.0
	target-lexicon-0.12.5
	version_check-0.9.4
	wasi-0.10.2+wasi-snapshot-preview1
"
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_10 )
QA_FLAGS_IGNORED=".*"

inherit cargo distutils-r1

DESCRIPTION="Fast, correct Python JSON library supporting dataclasses, datetimes, and numpy"
HOMEPAGE="https://github.com/ijl/orjson"
SRC_URI="
	https://github.com/ijl/orjson/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	$(cargo_crate_uris ${CRATES})
"

LICENSE="
	Apache-2.0 MIT
	BSD
	|| ( Apache-2.0 MIT )
	|| ( Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT )
	|| ( Apache-2.0 Boost-1.0 )
"
KEYWORDS="~amd64"
SLOT="0"
IUSE="debug"

BDEPEND="
	dev-util/maturin[${PYTHON_USEDEP}]
	dev-python/mypy[${PYTHON_USEDEP}]
	dev-python/autoflake[${PYTHON_USEDEP}]
	dev-python/black[${PYTHON_USEDEP}]
	dev-python/isort[${PYTHON_USEDEP}]
	dev-python/types-python-dateutil[${PYTHON_USEDEP}]
	dev-python/types-pytz[${PYTHON_USEDEP}]
	test? (
		dev-python/arrow[${PYTHON_USEDEP}]
		dev-python/orjson[${PYTHON_USEDEP}]
		dev-python/pendulum[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]

		$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]' python3_{8,9})
		$(python_gen_cond_dep '>=dev-python/xxhash-1.4.3[${PYTHON_USEDEP}]' python3_8)
	)
"

distutils_enable_tests pytest

src_unpack() {
	cargo_src_unpack
}
