# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
inherit python-single-r1

DESCRIPTION="A high-level, general-purpose, multi-paradigm, compiled programming language"
HOMEPAGE="https://www.swift.org"

SRC_URI="
	https://github.com/apple/swift-argument-parser/archive/refs/tags/1.2.3.tar.gz -> swift-argument-parser-1.2.3.tar.gz
	https://github.com/apple/swift-asn1/archive/refs/tags/1.0.0.tar.gz -> swift-asn1-1.0.0.tar.gz
	https://github.com/apple/swift-atomics/archive/refs/tags/1.0.2.tar.gz -> swift-atomics-1.0.2.tar.gz
	https://github.com/apple/swift-certificates/archive/refs/tags/1.0.1.tar.gz -> swift-certificates-1.0.1.tar.gz
	https://github.com/apple/swift-collections/archive/refs/tags/1.0.5.tar.gz -> swift-collections-1.0.5.tar.gz
	https://github.com/apple/swift-corelibs-foundation/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-corelibs-foundation-${PV}.tar.gz
	https://github.com/apple/swift-corelibs-libdispatch/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-corelibs-libdispatch-${PV}.tar.gz
	https://github.com/apple/swift-corelibs-xctest/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-corelibs-xctest-${PV}.tar.gz
	https://github.com/apple/swift-crypto/archive/refs/tags/3.0.0.tar.gz -> swift-crypto-3.0.0.tar.gz
	https://github.com/apple/swift-nio-ssl/archive/refs/tags/2.15.0.tar.gz -> swift-nio-ssl-2.15.0.tar.gz
	https://github.com/apple/swift-nio/archive/refs/tags/2.31.2.tar.gz -> swift-nio-2.31.2.tar.gz
	https://github.com/apple/swift-numerics/archive/refs/tags/1.0.1.tar.gz -> swift-numerics-1.0.1.tar.gz
	https://github.com/apple/swift-system/archive/refs/tags/1.1.1.tar.gz -> swift-system-1.1.1.tar.gz
	https://github.com/apple/swift-xcode-playground-support/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-xcode-playground-support-${PV}.tar.gz
	https://github.com/jpsim/Yams/archive/refs/tags/5.0.1.tar.gz -> Yams-5.0.1.tar.gz
	https://github.com/swiftlang/indexstore-db/archive/refs/tags/${P}-RELEASE.tar.gz -> indexstore-db-${PV}.tar.gz
	https://github.com/swiftlang/llvm-project/archive/refs/tags/${P}-RELEASE.tar.gz -> llvm-project-${PV}.tar.gz
	https://github.com/swiftlang/sourcekit-lsp/archive/refs/tags/${P}-RELEASE.tar.gz -> sourcekit-lsp-${PV}.tar.gz
	https://github.com/swiftlang/swift-cmark/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-cmark-${PV}.tar.gz
	https://github.com/swiftlang/swift-docc-render-artifact/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-docc-render-artifact-${PV}.tar.gz
	https://github.com/swiftlang/swift-docc-symbolkit/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-docc-symbolkit-${PV}.tar.gz
	https://github.com/swiftlang/swift-docc/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-docc-${PV}.tar.gz
	https://github.com/swiftlang/swift-driver/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-driver-${PV}.tar.gz
	https://github.com/swiftlang/swift-experimental-string-processing/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-experimental-string-processing-${PV}.tar.gz
	https://github.com/swiftlang/swift-format/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-format-${PV}.tar.gz
	https://github.com/swiftlang/swift-installer-scripts/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-installer-scripts-${PV}.tar.gz
	https://github.com/swiftlang/swift-integration-tests/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-integration-tests-${PV}.tar.gz
	https://github.com/swiftlang/swift-llbuild/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-llbuild-${PV}.tar.gz
	https://github.com/swiftlang/swift-llvm-bindings/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-llvm-bindings-${PV}.tar.gz
	https://github.com/swiftlang/swift-lmdb/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-lmdb-${PV}.tar.gz
	https://github.com/swiftlang/swift-markdown/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-markdown-${PV}.tar.gz
	https://github.com/swiftlang/swift-package-manager/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-package-manager-${PV}.tar.gz
	https://github.com/swiftlang/swift-stress-tester/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-stress-tester-${PV}.tar.gz
	https://github.com/swiftlang/swift-syntax/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-syntax-${PV}.tar.gz
	https://github.com/swiftlang/swift-tools-support-core/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-tools-support-core-${PV}.tar.gz
	https://github.com/swiftlang/swift/archive/refs/tags/${P}-RELEASE.tar.gz -> ${P}.tar.gz
"

PATCHES=(
	"${FILESDIR}/${P}-link-with-lld.patch"
	"${FILESDIR}/${P}-llbuild-link-ncurses-tinfo-gentoo.patch"
)

S="${WORKDIR}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="strip"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-db/sqlite-3
	>=dev-libs/icu-69
	>=dev-libs/libedit-20221030
	>=dev-libs/libxml2-2.11.5
	>=net-misc/curl-8.4
	>=sys-devel/lld-15
	>=sys-libs/ncurses-6
	>=sys-libs/zlib-1.3
	dev-lang/python
"

BDEPEND="
	${PYTHON_DEPS}
	>=dev-build/cmake-3.24.2
	>=dev-build/ninja-1.11
	>=dev-db/sqlite-3
	>=dev-libs/icu-69
	>=dev-libs/libedit-20221030
	>=dev-libs/libxml2-2.11.5
	>=dev-util/patchelf-0.18
	>=dev-vcs/git-2.39
	>=sys-apps/coreutils-9
	>=sys-devel/clang-15
	>=sys-devel/lld-15
	>=sys-libs/ncurses-6
	>=sys-libs/zlib-1.3
	dev-lang/python
	$(python_gen_cond_dep '
		dev-python/setuptools[${PYTHON_USEDEP}]
	' python3_{12..13})
"

src_unpack() {
	default

	# The Swift project expects a specific directory structure that we have to
	# match. For most directories, it's enough to trim the version number at the
	# end:
	find "${S}" \
		-mindepth 1 -maxdepth 1 \
		-execdir sh -c \
			"mv '{}' \"\$(echo '{}' | sed -e 's_-\(swift-5\.10\.1-RELEASE\|\([0-9]\+\.\)*[0-9]\+\)\$__' | tr '[:upper:]' '[:lower:]')\"" ';' \
		|| die

	# Some one-off fixups:
	pushd "${S}" \
		&& mv 'swift-cmark' 'cmark' \
		&& mv 'swift-llbuild' 'llbuild' \
		&& mv 'swift-package-manager' 'swiftpm' \
		&& popd \
		|| die
}

src_configure() {
	default

	# Necessary to respect PYTHON_SINGLE_TARGET, if defined.
	python_setup
}

src_compile() {
	# The Swift 5.10 compiler is partially written in Swift itself (the new
	# `swift-driver` + macro support via `swift-syntax`), which requires
	# bootstrapping with an existing Swift compiler.
	#
	# We don't have an existing Swift compiler, but we can bootstrap it with
	# itself in a 3-stage process:
	#
	# 0. We'll build LLVM+Clang and a bare Swift compiler with the old C++-based
	#    driver and no macro support
	# 1. We'll use that bare compiler to build a base compiler with the new
	#    Swift-based driver and macro support, with some base libs
	# 2. We'll then use that base compiler to build a full Swift toolchain with
	#    all necessary libs
	#
	# Build products will be intentionally shared between stages as much as
	# possible to avoid unnecessary repeated compilation.

	# Building swift-driver writes to this directory for some reason, but the
	# contents are irrelevant.
	addpredict /var/lib/portage/home/.swiftpm

	local _extra_cmake_options=(
		# BFD doesn't link Swift symbols properly, so we have to ensure Swift is
		# built with LLD.
		'-DSWIFT_USE_LINKER=lld',

		# We don't need to build any test code or test executables, which Swift
		# (and some components) does by default.
		'-DBUILD_TESTING:BOOL=NO',
		'-DSWIFT_INCLUDE_TESTS:BOOL=NO',
		'-DSWIFT_INCLUDE_TEST_BINARIES:BOOL=NO',

		# The Clang `compiler-rt` library builds the LLVM ORC JIT component by
		# default, which we don't need; the component builds with an executable
		# stack, which we'd like to avoid.
		'-DCOMPILER_RT_BUILD_ORC:BOOL=NO'
	)
	local extra_cmake_options="$(IFS=,; echo "${_extra_cmake_options[*]}")"

	# stage0:
	# * Bare Swift compiler (no bootstrapping; no Swift driver or macros)
	# * LLVM+Clang; this is the only stage where these are built because as a
	#   base dependency, their flags never change, and the build products can be
	#   reused
	"${S}/swift/utils/build-script" \
		--verbose-build \
		--release \
		--install-destdir="${S}/stage0" \
		--extra-cmake-options="${extra_cmake_options}" \
		--bootstrapping=off \
		--build-swift-libexec=false \
		--llvm-install-components='llvm-ar;llvm-cov;llvm-profdata;IndexStore;clang;clang-resource-headers;compiler-rt;clangd;lld;LTO;clang-features-file' \
		--llvm-targets-to-build=host \
		--skip-build-benchmarks \
		--skip-early-swift-driver --skip-early-swiftsyntax \
		--skip-test-cmark \
		--skip-test-linux \
		--skip-test-swift \
		--install-all \
		|| die

	# stage1:
	# * Base Swift compiler and driver (bootstrapping from stage1; with macros)
	# * Base libs: swift-driver depends on llbuild + swiftpm, which depend on
	#   Foundation + libdispatch + XCTest
	local original_path="${PATH}"
	export PATH="${S}/stage0/usr/bin:${original_path}"
	"${S}/swift/utils/build-script" \
		--verbose-build \
		--release \
		--install-destdir="${S}/stage1" \
		--extra-cmake-options="${extra_cmake_options}" \
		--build-swift-libexec=false \
		--cmark --skip-test-cmark \
		--foundation --skip-test-foundation \
		--libdispatch --skip-test-libdispatch \
		--llbuild --skip-test-llbuild \
		--skip-build-benchmarks \
		--skip-build-llvm \
		--skip-test-linux \
		--skip-test-swift \
		--swift-driver --skip-test-swift-driver \
		--swiftpm --skip-test-swiftpm \
		--xctest --skip-test-xctest \
		--install-all \
		|| die

	# stage2: full Swift toolchain (bootstrapping from stage2)
	export PATH="${S}/stage1/usr/bin:${original_path}"
	"${S}/swift/utils/build-script" \
		--verbose-build \
		--release \
		--install-destdir="${S}/stage2" \
		--extra-cmake-options="${extra_cmake_options}" \
		--build-swift-libexec=false \
		--foundation --skip-test-foundation \
		--indexstore-db --skip-test-indexstore-db \
		--libdispatch --skip-test-libdispatch \
		--llbuild --skip-test-llbuild \
		--lldb --skip-test-lldb \
		--skip-build-benchmarks \
		--skip-build-llvm \
		--skip-test-linux \
		--skip-test-swift \
		--sourcekit-lsp --skip-test-sourcekit-lsp \
		--swift-driver --skip-test-swift-driver \
		--swift-install-components='autolink-driver;compiler;clang-resource-dir-symlink;stdlib;swift-remote-mirror;sdk-overlay;static-mirror-lib;toolchain-tools;license;sourcekit-inproc' \
		--swiftdocc --skip-test-swiftdocc \
		--swiftpm --skip-test-swiftpm \
		--xctest --skip-test-xctest \
		--install-all \
		|| die

	export PATH="${original_path}"
}

src_install() {
	# The Swift build output is intended to be self-contained, and is
	# _significantly_ easier to leave as-is than attempt to splat onto the
	# filesystem; we'll install the output versioned into `/usr/lib64` and
	# expose the relevant binaries via linking.
	local dest_dir="/usr/lib64/${P}"
	mkdir -p "${ED}/${dest_dir}" \
		&& cp -pPR "${S}/stage2/." "${ED}/${dest_dir}" \
		|| die

	# Swift ships with its own `clang`, `lldb`, etc.; we don't want these to be
	# exposed externally, so we'll just symlink Swift-specific binaries into
	# `/usr/bin`. (The majority of executables don't need to be exposed as
	# `swift <command>` calls `swift-<command>` directly.)
	local bin
	for bin in swift swiftc sourcekit-lsp; do
		dosym -r "${dest_dir}/usr/bin/${bin}" "/usr/bin/${bin}"
	done
}
