# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYPI_VERIFY_REPO=https://github.com/prefectlabs/burner-redis
PYTHON_COMPAT=( python3_{12..14} )

RUST_MIN_VER="1.85.0"
CRATES="
	autocfg@1.5.0
	bitflags@2.11.0
	block-buffer@0.10.4
	bstr@1.12.1
	bytes@1.11.1
	cc@1.2.60
	cfg-if@1.0.4
	cpufeatures@0.2.17
	crypto-common@0.1.7
	digest@0.10.7
	either@1.15.0
	env_home@0.1.0
	errno@0.3.14
	find-msvc-tools@0.1.9
	futures-channel@0.3.32
	futures-core@0.3.32
	futures-macro@0.3.32
	futures-task@0.3.32
	futures-util@0.3.32
	generic-array@0.14.7
	heck@0.5.0
	libc@0.2.184
	linux-raw-sys@0.12.1
	lock_api@0.4.14
	lua-src@547.0.0
	luajit-src@210.5.12+a4f56a4
	memchr@2.8.0
	mlua-sys@0.6.8
	mlua@0.10.5
	num-traits@0.2.19
	once_cell@1.21.4
	ordered-float@5.3.0
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	pin-project-lite@0.2.17
	pkg-config@0.3.32
	portable-atomic@1.13.1
	proc-macro2@1.0.106
	pyo3-async-runtimes@0.28.0
	pyo3-build-config@0.28.3
	pyo3-ffi@0.28.3
	pyo3-macros-backend@0.28.3
	pyo3-macros@0.28.3
	pyo3@0.28.3
	quote@1.0.45
	redox_syscall@0.5.18
	rmp-serde@1.3.1
	rmp@0.8.15
	rustc-hash@2.1.2
	rustix@1.1.4
	rustversion@1.0.22
	scopeguard@1.2.0
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	sha1@0.10.6
	shlex@1.3.0
	slab@0.4.12
	smallvec@1.15.1
	syn@2.0.117
	target-lexicon@0.13.5
	thiserror-impl@2.0.18
	thiserror@2.0.18
	tokio-macros@2.7.0
	tokio@1.51.1
	typenum@1.19.0
	unicode-ident@1.0.24
	version_check@0.9.5
	which@7.0.3
	windows-link@0.2.1
	windows-sys@0.61.2
	winsafe@0.0.19
"

inherit cargo distutils-r1 pypi

DESCRIPTION="An embedded, in-process Redis-compatible database"
HOMEPAGE="
	https://github.com/prefectlabs/burner-redis
	https://pypi.org/project/burner-redis/
"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND="
	test? (
		dev-python/redis[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest

src_unpack() {
	cargo_src_unpack
}
