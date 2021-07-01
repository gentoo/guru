# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
	ahash-0.7.4
	arrayvec-0.5.2
	associative-cache-1.0.1
	bitflags-1.2.1
	bytecount-0.6.2
	cfg-if-0.1.10
	cfg-if-1.0.0
	encoding_rs-0.8.28
	getrandom-0.2.3
	inlinable_string-0.1.14
	instant-0.1.9
	itoa-0.4.7
	lexical-core-0.7.6
	libc-0.2.95
	libm-0.1.4
	lock_api-0.4.4
	once_cell-1.7.2
	packed_simd_2-0.3.5
	parking_lot-0.11.1
	parking_lot_core-0.8.3
	pyo3-0.13.2
	redox_syscall-0.2.8
	ryu-1.0.5
	scopeguard-1.1.0
	serde-1.0.126
	smallvec-1.6.1
	static_assertions-1.1.0
	version_check-0.9.3
	wasi-0.10.2+wasi-snapshot-preview1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-x86_64-pc-windows-gnu-0.4.0
"
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{8..9} )

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

DEPEND="
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
"
BDEPEND="
	app-arch/unzip
	dev-lang/rust[nightly]
	dev-util/maturin
"

QA_FLAGS_IGNORED="$(python_get_sitedir)/${PN}*.so"

distutils_enable_tests pytest

src_compile() {
	maturin build --no-sdist --manylinux off --interpreter ${EPYTHON} $(usex debug "" --release) || die
	unzip "target/wheels/${P}-*.whl" || die
}

src_install() {
	python_domodule "${PN}"*.so
	dodoc README.md
}

python_test() {
	epytest -vv \
		--deselect test/test_datetime.py::DatetimeTests::test_datetime_pendulum_positive \
		--deselect test/test_datetime.py::DatetimeTests::test_datetime_partial_second_pendulum_supported \
		--deselect test/test_datetime.py::DatetimeTests::test_datetime_pendulum_negative_dst \
		--deselect test/test_datetime.py::DatetimeTests::test_datetime_pendulum_negative_non_dst \
		--deselect test/test_datetime.py::DatetimeTests::test_datetime_partial_hour \
		--deselect test/test_datetime.py::DatetimeTests::test_datetime_pendulum_partial_hour \
		|| die
}
