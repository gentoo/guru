# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	ahash-0.7.6
	arrayvec-0.7.2
	associative-cache-1.0.1
	autocfg-1.1.0
	bitflags-1.3.2
	bytecount-0.6.2
	cfg-if-1.0.0
	chrono-0.4.19
	encoding_rs-0.8.30
	getrandom-0.2.4
	inlinable_string-0.1.15
	instant-0.1.12
	itoa-1.0.1
	libc-0.2.117
	libm-0.1.4
	lock_api-0.4.6
	num-integer-0.1.44
	num-traits-0.2.14
	once_cell-1.9.0
	packed_simd_2-0.3.7
	parking_lot-0.11.2
	parking_lot_core-0.8.5
	pyo3-0.15.1
	pyo3-build-config-0.15.1
	redox_syscall-0.2.10
	ryu-1.0.9
	scopeguard-1.1.0
	serde-1.0.136
	serde_json-1.0.79
	simdutf8-0.1.3
	smallvec-1.8.0
	version_check-0.9.4
	wasi-0.10.2+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0

"
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_SETUPTOOLS=no
EPYTEST_DESELECT=(
	test/test_datetime.py::DatetimeTests::test_datetime_pendulum_positive
	test/test_datetime.py::DatetimeTests::test_datetime_partial_second_pendulum_supported
	test/test_datetime.py::DatetimeTests::test_datetime_pendulum_negative_dst
	test/test_datetime.py::DatetimeTests::test_datetime_pendulum_negative_non_dst
	test/test_datetime.py::DatetimeTests::test_datetime_partial_hour
	test/test_datetime.py::DatetimeTests::test_datetime_pendulum_partial_hour
	test/test_api.py::ApiTests::test_version
)
PYTHON_COMPAT=( python3_{8..9} )
QA_FLAGS_IGNORED="*"

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
		$(python_gen_cond_dep '
			dev-python/arrow[${PYTHON_USEDEP}]
			dev-python/orjson[${PYTHON_SINGLE_USEDEP}]
			dev-python/pendulum[${PYTHON_USEDEP}]
			dev-python/psutil[${PYTHON_USEDEP}]
			dev-python/pytz[${PYTHON_USEDEP}]
		')

		$(python_gen_cond_dep 'dev-python/numpy[${PYTHON_USEDEP}]' python3_{8,9})
		$(python_gen_cond_dep '>=dev-python/xxhash-1.4.3[${PYTHON_USEDEP}]' python3_8)
	)
	app-arch/unzip
	dev-lang/rust[nightly]
	dev-util/maturin
"

QA_FLAGS_IGNORED=".*"

distutils_enable_tests pytest

src_compile() {
	maturin build --no-sdist --manylinux off --interpreter ${EPYTHON} $(usex debug "" --release) || die
	unzip target/wheels/${P}-*.whl || die
}

src_install() {
	python_domodule orjson/orjson*.so
	dodoc README.md
}
