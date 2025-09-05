# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {15..19} )
PYTHON_COMPAT=( python3_{11..13} )
inherit flag-o-matic llvm-r1 python-single-r1

DESCRIPTION="A high-level, general-purpose, multi-paradigm, compiled programming language"
HOMEPAGE="https://www.swift.org"

SRC_URI="
	https://github.com/apple/swift-argument-parser/archive/refs/tags/1.2.3.tar.gz -> swift-argument-parser-1.2.3.tar.gz
	https://github.com/apple/swift-asn1/archive/refs/tags/1.0.0.tar.gz -> swift-asn1-1.0.0.tar.gz
	https://github.com/apple/swift-atomics/archive/refs/tags/1.0.2.tar.gz -> swift-atomics-1.0.2.tar.gz
	https://github.com/apple/swift-certificates/archive/refs/tags/1.0.1.tar.gz -> swift-certificates-1.0.1.tar.gz
	https://github.com/apple/swift-collections/archive/refs/tags/1.0.5.tar.gz -> swift-collections-1.0.5.tar.gz
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
	https://github.com/swiftlang/swift-corelibs-foundation/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-corelibs-foundation-${PV}.tar.gz
	https://github.com/swiftlang/swift-corelibs-libdispatch/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-corelibs-libdispatch-${PV}.tar.gz
	https://github.com/swiftlang/swift-corelibs-xctest/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-corelibs-xctest-${PV}.tar.gz
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
	"${FILESDIR}/${PF}/backport-swift-75662.patch"
	"${FILESDIR}/${PF}/backtracing-noexecstack.patch"
	"${FILESDIR}/${PF}/clang-indexstore-exports.patch"
	"${FILESDIR}/${PF}/disable-libdispatch-werror.patch"
	"${FILESDIR}/${PF}/fix-issues-caused-by-build-system-updates.patch"
	"${FILESDIR}/${PF}/link-ncurses-tinfo.patch"
	"${FILESDIR}/${PF}/link-with-lld.patch"
	"${FILESDIR}/${PF}/lldb-cmake-minimum-version.patch"
	"${FILESDIR}/${PF}/respect-c-cxx-flags.patch"
)

S="${WORKDIR}"
LICENSE="Apache-2.0"
SLOT="5/10"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="strip"

RDEPEND="
	${PYTHON_DEPS}
	>=app-arch/zstd-1.5
	>=app-eselect/eselect-swift-1.0-r1
	>=dev-db/sqlite-3
	>=dev-libs/icu-69
	>=dev-libs/libedit-20221030
	>=dev-libs/libxml2-2.11.5
	>=net-misc/curl-8.4
	>=sys-libs/ncurses-6
	>=sys-libs/zlib-1.3
	dev-lang/python
	$(llvm_gen_dep 'llvm-core/lld:${LLVM_SLOT}=')
"

BDEPEND="
	${PYTHON_DEPS}
	>=dev-build/cmake-3.24.2
	>=dev-build/ninja-1.11
	>=dev-db/sqlite-3
	>=dev-libs/icu-69
	>=dev-libs/libedit-20221030
	>=dev-libs/libxml2-2.11.5
	>=dev-vcs/git-2.39
	>=sys-apps/coreutils-9
	>=sys-devel/gcc-11
	>=sys-libs/ncurses-6
	>=sys-libs/zlib-1.3
	$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}=
		llvm-core/lld:${LLVM_SLOT}=
	')
	dev-lang/python
	$(python_gen_cond_dep '
		dev-python/setuptools[${PYTHON_USEDEP}]
	' python3_{12..13})
"

PKG_PREINST_SWIFT_INTENTIONALLY_SET='true'

# Adapted from `flag-o-matic.eclass`'s `raw-ldflags`: turns GCC-style flags
# (`-Wl,-foo`) into Clang-style flags (`-Xlinker -foo`).
clang-ldflags() {
	local flag input="$@"
	[[ -z ${input} ]] && input=${LDFLAGS}
	set --
	for flag in ${input//,/ } ; do
		case ${flag} in
			-Wl) ;;
			*) set -- "$@" "-Xlinker ${flag}" ;;
		esac
	done
	echo "$@"
}

pkg_setup() {
	# Sets `${EPYTHON}` according to `PYTHON_SINGLE_TARGET`, sets up
	# `${T}/${EPYTHON}` with that version, and adds it to the `PATH`.
	python_setup

	# Sets up `PATH` to point to the appropriate LLVM toolchain.
	llvm-r1_pkg_setup
}

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
	# `llvm-r1_pkg_setup` sets these tools to their absolute paths, but we need
	# to still pick them up dynamically based on `PATH` for stage1 and stage2
	# builds below (to keep all parts of the Swift toolchain compiling with the
	# same internal tools).
	export CC="clang"
	export CXX="clang++"
	export LD="ld.lld"

	# Swift builds with CMake, which picks up `LDFLAGS` from the environment and
	# populates `CMAKE_EXE_LINKER_FLAGS` with them. `LDFLAGS` are typically
	# given as GCC-style flags (`-Wl,foo`), which Clang understands;
	# unfortunately, CMake passes these flags to all compilers under the
	# assumption they support the same syntax, but `swiftc` _only_ understands
	# Clang-style flags (`-Xlinker -foo`). In order to pass `LDFLAGS` in, we
	# have to turn them into a format that `swiftc` will understand.
	#
	# We can do this because we know we're compiling with Clang specifically.
	export LDFLAGS="$(clang-ldflags)"

	# Bug 949266
	# Swift 5 requires building against `libstdc++`, but when building with
	# `llvm-core/clang-common[default-libcxx]` (e.g., on the LLVM profile), LLVM
	# and Clang default to `libc++`. This leads to some symbols getting picked
	# up from `libc++` and others from `libstdc++`, leading to linker failures.
	# This requires forcing the usage of `libstdc++` to build consistently.
	append-cxxflags '-stdlib=libstdc++'
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

	# Setting `-j<n>`/`--jobs=<n>` in MAKEOPTS needs to be manually exposed to
	# the Swift build system.
	local jobs_flag
	if [[ -n "${MAKEOPTS}" ]]; then
		local num_jobs make_opts=( $(getopt -qu -o 'j:' -l 'jobs:' -- ${MAKEOPTS}) )
		while [[ "${#make_opts[@]}" -gt 1 ]]; do
			case "${make_opts[0]}" in
				-j | --jobs )
					num_jobs="${make_opts[1]}"
					make_opts=("${make_opts[@]:2}") ;;
				-- ) break ;;
				* ) make_opts=("${make_opts[@]:1}") ;;
			esac
		done

		if [[ -n "${num_jobs}" ]]; then
			jobs_flag="--jobs=${num_jobs}"
		fi
	fi

	local _extra_cmake_options=(
		# BFD doesn't link Swift symbols properly, so we have to ensure Swift is
		# built with LLD.
		'-DSWIFT_USE_LINKER=lld',
		'-DLLVM_USE_LINKER=lld',

		# We don't need to build any test code or test executables, which Swift
		# (and some components) does by default.
		'-DBUILD_TESTING:BOOL=NO',
		'-DSWIFT_INCLUDE_TESTS:BOOL=NO',
		'-DSWIFT_INCLUDE_TEST_BINARIES:BOOL=NO',

		# The Clang `compiler-rt` library builds the LLVM ORC JIT component by
		# default, which we don't need; the component builds with an executable
		# stack, which we'd like to avoid.
		'-DCOMPILER_RT_BUILD_ORC:BOOL=NO',

		# LLDB ships with Python bindings, and uses CMake to search for Python.
		# By default, CMake tries to find the latest version of Python available
		# on disk (currently `python3.13`, then `python3.12`, then...). This
		# might not be the version of Python the rest of the system uses, or
		# which is specified by `PYTHON_SINGLE_TARGET`.
		#
		# Since `python_setup` already places `${EPYTHON}` in the `PATH`, we can
		# tell CMake to use the unversioned `python` rather than a versioned
		# one to end up respecting `PYTHON_SINGLE_TARGET`.
		'-DPython3_FIND_UNVERSIONED_NAMES=FIRST'
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
		--no-assertions \
		--build-subdir="Ninja-Release" \
		--install-destdir="${S}/stage0" \
		"${jobs_flag}" \
		--extra-cmake-options="${extra_cmake_options}" \
		--bootstrapping=off \
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
	# * Base Swift compiler and driver (bootstrapping from stage0; with macros)
	# * Base libs: swift-driver depends on llbuild + swiftpm, which depend on
	#   Foundation + libdispatch + XCTest
	local original_path="${PATH}"
	export PATH="${S}/stage0/usr/bin:${original_path}"
	"${S}/swift/utils/build-script" \
		--verbose-build \
		--release \
		--no-assertions \
		--build-subdir="Ninja-Release" \
		--install-destdir="${S}/stage1" \
		"${jobs_flag}" \
		--extra-cmake-options="${extra_cmake_options}" \
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

	# stage2: full Swift toolchain (bootstrapping from stage1)
	export PATH="${S}/stage1/usr/bin:${original_path}"
	"${S}/swift/utils/build-script" \
		--verbose-build \
		--release \
		--no-assertions \
		--build-subdir="Ninja-Release" \
		--install-destdir="${S}/stage2" \
		"${jobs_flag}" \
		--extra-cmake-options="${extra_cmake_options}" \
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
	# filesystem; we'll install the output versioned into `/usr/$(get_libdir)`
	# and expose the relevant binaries via linking.
	local dest_dir="/usr/$(get_libdir)/${P}"
	mkdir -p "${ED}/${dest_dir}" \
		&& cp -pPR "${S}/stage2/." "${ED}/${dest_dir}" \
		|| die

	# We also want to provide a stable directory which matches our SLOT to avoid
	# revdep breakages, as patch updates use the same SLOT but otherwise move
	# the install location on disk.
	#
	# See https://bugs.gentoo.org/957730
	dosym -r "${dest_dir}" "/usr/$(get_libdir)/${PN}-$(ver_cut 1-2)"

	# Swift ships with its own `clang`, `lldb`, etc.; we don't want these to be
	# exposed externally, so we'll just symlink Swift-specific binaries into
	# `/usr/bin`. (The majority of executables don't need to be exposed as
	# `swift <command>` calls `swift-<command>` directly.)
	local bin
	for bin in swift swiftc sourcekit-lsp; do
		# We only install versioned symlinks; non-versioned links are maanged
		# via `eselect swift`.
		dosym -r "${dest_dir}/usr/bin/${bin}" "/usr/bin/${bin}-${PV}"
	done
}

pkg_preinst() {
	# After installation, we ideally want the system to have the latest Swift
	# version set -- but if the system already has a Swift version set and it
	# isn't the latest version, that's likely an intentional decision that we
	# don't want to override.
	local current_swift_version="$(eselect swift show | tail -n1 | xargs)"
	local latest_swift_version="$(eselect swift show --latest | tail -n1 | xargs)"
	[[ "${current_swift_version}" == '(unset)' ]] \
		|| [[ "${current_swift_version}" == "${latest_swift_version}" ]] \
		&& PKG_PREINST_SWIFT_INTENTIONALLY_SET='false'
}

pkg_postinst() {
	# If the system doesn't have Swift intentionally set to an older version, we
	# can update to the latest.
	if [[ "${PKG_PREINST_SWIFT_INTENTIONALLY_SET}" == 'false' ]]; then
		eselect swift update
	fi
}

pkg_postrm() {
	# We don't want to leave behind symlinks pointing to this Swift version on
	# removal.
	local current_swift_version="$(eselect swift show | tail -n1 | xargs)"
	if [[ "${current_swift_version}" == "${P}" ]]; then
		eselect swift update
	fi
}
