# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {15..19} )
PYTHON_COMPAT=( python3_{11..13} )
inherit llvm-r1 python-single-r1 toolchain-funcs

DESCRIPTION="A high-level, general-purpose, multi-paradigm, compiled programming language"
HOMEPAGE="https://www.swift.org"

SRC_URI="
	https://github.com/apple/swift-argument-parser/archive/refs/tags/1.4.0.tar.gz -> swift-argument-parser-1.4.0.tar.gz
	https://github.com/apple/swift-asn1/archive/refs/tags/1.0.0.tar.gz -> swift-asn1-1.0.0.tar.gz
	https://github.com/apple/swift-async-algorithms/archive/refs/tags/1.0.1.tar.gz -> swift-async-algorithms-1.0.0.tar.gz
	https://github.com/apple/swift-atomics/archive/refs/tags/1.2.0.tar.gz -> swift-atomics-1.2.0.tar.gz
	https://github.com/apple/swift-certificates/archive/refs/tags/1.0.1.tar.gz -> swift-certificates-1.0.1.tar.gz
	https://github.com/apple/swift-collections/archive/refs/tags/1.1.3.tar.gz -> swift-collections-1.1.3.tar.gz
	https://github.com/apple/swift-crypto/archive/refs/tags/3.0.0.tar.gz -> swift-crypto-3.0.0.tar.gz
	https://github.com/apple/swift-log/archive/refs/tags/1.5.4.tar.gz -> swift-log-1.5.4.tar.gz
	https://github.com/apple/swift-nio/archive/refs/tags/2.65.0.tar.gz -> swift-nio-2.65.0.tar.gz
	https://github.com/apple/swift-numerics/archive/refs/tags/1.0.2.tar.gz -> swift-numerics-1.0.2.tar.gz
	https://github.com/apple/swift-system/archive/refs/tags/1.3.0.tar.gz -> swift-system-1.3.0.tar.gz
	https://github.com/jpsim/Yams/archive/refs/tags/5.0.6.tar.gz -> Yams-5.0.6.tar.gz
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
	https://github.com/swiftlang/swift-foundation-icu/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-foundation-icu-${PV}.tar.gz
	https://github.com/swiftlang/swift-foundation/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-foundation-${PV}.tar.gz
	https://github.com/swiftlang/swift-installer-scripts/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-installer-scripts-${PV}.tar.gz
	https://github.com/swiftlang/swift-integration-tests/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-integration-tests-${PV}.tar.gz
	https://github.com/swiftlang/swift-llbuild/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-llbuild-${PV}.tar.gz
	https://github.com/swiftlang/swift-llvm-bindings/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-llvm-bindings-${PV}.tar.gz
	https://github.com/swiftlang/swift-lmdb/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-lmdb-${PV}.tar.gz
	https://github.com/swiftlang/swift-markdown/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-markdown-${PV}.tar.gz
	https://github.com/swiftlang/swift-package-manager/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-package-manager-${PV}.tar.gz
	https://github.com/swiftlang/swift-stress-tester/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-stress-tester-${PV}.tar.gz
	https://github.com/swiftlang/swift-syntax/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-syntax-${PV}.tar.gz
	https://github.com/swiftlang/swift-testing/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-testing-${PV}.tar.gz
	https://github.com/swiftlang/swift-toolchain-sqlite/archive/refs/tags/1.0.1.tar.gz -> swift-toolchain-sqlite-1.0.1.tar.gz
	https://github.com/swiftlang/swift-tools-support-core/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-tools-support-core-${PV}.tar.gz
	https://github.com/swiftlang/swift/archive/refs/tags/${P}-RELEASE.tar.gz -> ${P}.tar.gz
"

PATCHES=(
	"${FILESDIR}/${PF}/backtracing-noexecstack.patch"
	"${FILESDIR}/${PF}/disable-libdispatch-werror.patch"
	"${FILESDIR}/${PF}/fix-issues-caused-by-build-system-updates.patch"
	"${FILESDIR}/${PF}/link-ncurses-tinfo.patch"
	"${FILESDIR}/${PF}/link-with-lld.patch"
	"${FILESDIR}/${PF}/respect-c-cxx-flags.patch"
)

S="${WORKDIR}"
LICENSE="Apache-2.0"
SLOT="6/1"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="strip"

RDEPEND="
	${PYTHON_DEPS}
	!~dev-lang/swift-5.10.1:0
	>=app-arch/zstd-1.5
	>=app-eselect/eselect-swift-1.0-r1
	>=dev-db/sqlite-3
	>=dev-libs/icu-69
	>=dev-libs/libedit-20221030
	>=dev-libs/libxml2-2.11.5
	>=net-misc/curl-8.9.1
	>=sys-libs/ncurses-6
	>=sys-libs/zlib-1.3.1
	dev-lang/python
	$(llvm_gen_dep 'llvm-core/lld:${LLVM_SLOT}=')
"

BDEPEND="
	${PYTHON_DEPS}
	>=dev-build/cmake-3.30.2
	>=dev-build/ninja-1.11.1
	>=dev-db/sqlite-3
	>=dev-libs/icu-69
	>=dev-libs/libedit-20221030
	>=dev-libs/libxml2-2.11.5
	>=dev-util/patchelf-0.18
	>=dev-vcs/git-2.39
	>=sys-apps/coreutils-9
	>=sys-devel/gcc-11
	>=sys-libs/ncurses-6
	>=sys-libs/zlib-1.3.1
	|| (
		dev-lang/swift
		dev-lang/swift-bootstrap
	)
	$(llvm_gen_dep '
		llvm-core/clang:${LLVM_SLOT}=
		llvm-core/lld:${LLVM_SLOT}=
	')
	dev-lang/python
	$(python_gen_cond_dep '
		dev-python/setuptools[${PYTHON_USEDEP}]
	' python3_{12..13})
"

SWIFT_BUILD_PRESETS_INI_PATH="${S}/gentoo-build-presets.ini"
SWIFT_BUILD_PRESET='gentoo'
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

	# Sets up `PATH` to point to the appropriate LLVM toolchain, and ensure
	# we're using the toolchain for compilation.
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
			"mv '{}' \"\$(echo '{}' | sed -e 's_-\(swift-${PV}-RELEASE\|\([0-9]\+\.\)*[0-9]\+\)\$__' | tr '[:upper:]' '[:lower:]')\"" ';' \
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
	CC="$(type -P clang)"
	CXX="$(type -P clang++)"
	LD="$(type -P ld.lld)"

	# Swift builds with CMake, which picks up `LDFLAGS` from the environment and
	# populates `CMAKE_EXE_LINKER_FLAGS` with them. `LDFLAGS` are typically
	# given as GCC-style flags (`-Wlinker,foo`), which Clang understands;
	# unfortunately, CMake passes these flags to all compilers under the
	# assumption they support the same syntax, but `swiftc` _only_ understands
	# Clang-style flags (`-Xlinker -foo`). In order to pass `LDFLAGS` in, we
	# have to turn them into a format that `swiftc` will understand.
	#
	# We can do this because we know we're compiling with Clang specifically.
	export LDFLAGS="$(clang-ldflags)"

	# Extend the 'gentoo' build preset with user-specified flags and flags for
	# libc++ systems.
	cp "${FILESDIR}/${PF}/gentoo.ini" "${SWIFT_BUILD_PRESETS_INI_PATH}"
	local extra_build_flags=()

	# Setting `-j<n>`/`--jobs=<n>` in MAKEOPTS needs to be manually exposed to
	# the Swift build system.
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
			extra_build_flags+=(--jobs="${num_jobs}")
		fi
	fi

	if [[ "$(tc-get-cxx-stdlib)" = 'libc++' ]]; then
		# On systems which use libc++ as their default C++ stdlib (e.g. systems
		# with the LLVM profile), we want to build the internal libc++ and
		# ensure we link against it.
		extra_build_flags+=(
			--libcxx
			--extra-cmake-options=-DCLANG_DEFAULT_CXX_STDLIB=libc++
		)
	fi

	extra_build_flags+=(${SWIFT_EXTRA_BUILD_FLAGS})

	local orig_preset="${SWIFT_BUILD_PRESET}"
	local preset="${orig_preset}"
	local n=1

	{
		for arg in "${extra_build_flags[@]}"; do
			local next="${orig_preset},${n}"
			printf '[preset: %s]\n' "${next}"
			printf 'mixin-preset=%s\n' "${preset}"
			echo "${arg#--}"
			preset="${next}"
			n="$((n + 1))"
		done
	} >> "${SWIFT_BUILD_PRESETS_INI_PATH}"

	SWIFT_BUILD_PRESET="${preset}"
}

src_compile() {
	# Building swift-driver writes to this directory for some reason, but the
	# contents are irrelevant.
	addpredict /var/lib/portage/home/.swiftpm

	# Versions of Swift 6.0 and later require an existing Swift compiler to
	# bootstrap from. We can use any version from 5.10.1 and on.
	local swift_version="$(best_version -b "${CATEGORY}/${PN}")"
	swift_version="${swift_version#${CATEGORY}/}" # reduce to ${PVR} form
	swift_version="${swift_version%-r[[:digit:]]*}" # reduce to ${P} form

	local original_path="${PATH}"
	export PATH="/usr/lib64/${swift_version}/usr/bin:${original_path}"
	"${S}/swift/utils/build-script" \
		--preset-file="${S}/swift/utils/build-presets.ini" \
		--preset-file="${SWIFT_BUILD_PRESETS_INI_PATH}" \
		--preset="${SWIFT_BUILD_PRESET}" \
		install_destdir="${S}/${P}" \
		installable_package="" \
		|| die

	export PATH="${original_path}"
}

src_install() {
	# `libTesting` as built has its RPATH set to the absolute path to its
	# containing dir, which is in the build sandbox. This directory won't exist
	# after installation, and is the same as '$ORIGIN'.
	patchelf --set-rpath '$ORIGIN' "${S}/${P}/usr/lib/swift/linux/libTesting.so" || die

	# The Swift build output is intended to be self-contained, and is
	# _significantly_ easier to leave as-is than attempt to splat onto the
	# filesystem; we'll install the output versioned into `/usr/$(get_libdir)`
	# and expose the relevant binaries via linking.
	local dest_dir="/usr/$(get_libdir)/${P}"
	mkdir -p "${ED}/${dest_dir}" \
		&& cp -pPR "${S}/${P}/." "${ED}/${dest_dir}" \
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
