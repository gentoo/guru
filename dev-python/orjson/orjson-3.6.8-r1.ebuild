# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
CRATES="
	ahash-0.7.6
	arrayvec-0.7.2
	associative-cache-1.0.1
	autocfg-1.1.0
	bytecount-0.6.2
	cfg-if-1.0.0
	chrono-0.4.19
	encoding_rs-0.8.31
	getrandom-0.2.6
	inlinable_string-0.1.15
	itoa-1.0.1
	libc-0.2.123
	libm-0.1.4
	num-integer-0.1.44
	num-traits-0.2.14
	once_cell-1.10.0
	packed_simd_2-0.3.7
	pyo3-build-config-0.16.4
	pyo3-ffi-0.16.4
	ryu-1.0.9
	serde-1.0.136
	serde_json-1.0.79
	simdutf8-0.1.4
	smallvec-1.8.0
	target-lexicon-0.12.3
	version_check-0.9.4
	wasi-0.10.2+wasi-snapshot-preview1
"
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{8..9} )
QA_FLAGS_IGNORED=".*"

inherit cargo distutils-r1

DESCRIPTION="Fast, correct Python JSON library supporting dataclasses, datetimes, and numpy"
HOMEPAGE="https://github.com/ijl/orjson"
SRC_URI="
	https://github.com/ijl/orjson/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
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
	test? (
		dev-python/arrow[${PYTHON_USEDEP}]
		dev-python/orjson[${PYTHON_USEDEP}]
		dev-python/pendulum[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]

		$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]' python3_{8,9})
		$(python_gen_cond_dep '>=dev-python/xxhash-1.4.3[${PYTHON_USEDEP}]' python3_8)
	)
"

PATCHES=( "${FILESDIR}/${PN}-3.6.7-no-strip.patch" )

distutils_enable_tests pytest
