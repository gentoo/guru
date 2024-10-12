# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LLVM_COMPAT=( {15..18} )
PYTHON_COMPAT=( python3_{10..13} )
inherit llvm-r1 python-single-r1

DESCRIPTION="A high-level, general-purpose, multi-paradigm, compiled programming language"
HOMEPAGE="https://www.swift.org"

SRC_URI="
	https://github.com/apple/swift-argument-parser/archive/refs/tags/1.2.3.tar.gz -> swift-argument-parser-1.2.3.tar.gz
	https://github.com/apple/swift-asn1/archive/refs/tags/1.0.0.tar.gz -> swift-asn1-1.0.0.tar.gz
	https://github.com/apple/swift-atomics/archive/refs/tags/1.2.0.tar.gz -> swift-atomics-1.2.0.tar.gz
	https://github.com/apple/swift-certificates/archive/refs/tags/1.0.1.tar.gz -> swift-certificates-1.0.1.tar.gz
	https://github.com/apple/swift-collections/archive/refs/tags/1.1.2.tar.gz -> swift-collections-1.1.2.tar.gz
	https://github.com/apple/swift-corelibs-libdispatch/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-corelibs-libdispatch-${PV}.tar.gz
	https://github.com/apple/swift-crypto/archive/refs/tags/3.0.0.tar.gz -> swift-crypto-3.0.0.tar.gz
	https://github.com/apple/swift-nio-ssl/archive/refs/tags/2.15.0.tar.gz -> swift-nio-ssl-2.15.0.tar.gz
	https://github.com/apple/swift-nio/archive/refs/tags/2.31.2.tar.gz -> swift-nio-2.31.2.tar.gz
	https://github.com/apple/swift-numerics/archive/refs/tags/1.0.2.tar.gz -> swift-numerics-1.0.2.tar.gz
	https://github.com/apple/swift-system/archive/refs/tags/1.3.0.tar.gz -> swift-system-1.3.0.tar.gz
	https://github.com/jpsim/Yams/archive/refs/tags/5.0.6.tar.gz -> Yams-5.0.6.tar.gz
	https://github.com/swiftlang/indexstore-db/archive/refs/tags/${P}-RELEASE.tar.gz -> indexstore-db-${PV}.tar.gz
	https://github.com/swiftlang/llvm-project/archive/refs/tags/${P}-RELEASE.tar.gz -> llvm-project-${PV}.tar.gz
	https://github.com/swiftlang/sourcekit-lsp/archive/refs/tags/${P}-RELEASE.tar.gz -> sourcekit-lsp-${PV}.tar.gz
	https://github.com/swiftlang/swift-cmark/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-cmark-${PV}.tar.gz
	https://github.com/swiftlang/swift-corelibs-foundation/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-corelibs-foundation-${PV}.tar.gz
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
	https://github.com/swiftlang/swift-tools-support-core/archive/refs/tags/${P}-RELEASE.tar.gz -> swift-tools-support-core-${PV}.tar.gz
	https://github.com/swiftlang/swift/archive/refs/tags/${P}-RELEASE.tar.gz -> ${P}.tar.gz
"

PATCHES=(
	"${FILESDIR}/${P}-link-with-lld.patch"
	"${FILESDIR}/${P}-swift-backtracing-noexecstack-gentoo.patch"
	"${FILESDIR}/${P}-swift-build-preset-gentoo.patch"
	"${FILESDIR}/${P}-swift-link-ncurses-tinfo-gentoo.patch"
)

S="${WORKDIR}"
LICENSE="Apache-2.0"
SLOT="6/0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="strip"

RDEPEND="
	${PYTHON_DEPS}
	!~dev-lang/swift-5.10.1:0
	>=app-eselect/eselect-swift-1.0
	>=dev-db/sqlite-3
	>=dev-libs/icu-69
	>=dev-libs/libedit-20221030
	>=dev-libs/libxml2-2.11.5
	>=net-misc/curl-8.4
	>=sys-libs/ncurses-6
	>=sys-libs/zlib-1.3
	dev-lang/python
	$(llvm_gen_dep 'sys-devel/lld:${LLVM_SLOT}=')
"

BDEPEND="
	${PYTHON_DEPS}
	>=dev-build/cmake-3.24.2
	>=dev-build/ninja-1.11.1
	>=dev-db/sqlite-3
	>=dev-libs/icu-69
	>=dev-libs/libedit-20221030
	>=dev-libs/libxml2-2.11.5
	>=dev-util/patchelf-0.18
	>=dev-vcs/git-2.39
	>=sys-apps/coreutils-9
	>=sys-libs/ncurses-6
	>=sys-libs/zlib-1.3
	|| (
		<dev-lang/swift-${PV}:*
		>dev-lang/swift-${PV}:*
	)
	$(llvm_gen_dep '
		sys-devel/clang:${LLVM_SLOT}=
		sys-devel/lld:${LLVM_SLOT}=
	')
	dev-lang/python
	$(python_gen_cond_dep '
		dev-python/setuptools[${PYTHON_USEDEP}]
	' python3_{12..13})
"

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
	CC="$(type -P clang)"
	CXX="$(type -P clang++)"
	LD="$(type -P ld.lld)"

	# Swift builds with CMake, which picks up `LDFLAGS` from the environment and
	# populates `CMAKE_EXE_LINKER_FLAGS` with them. `LDFLAGS` are typically
	# given as GCC-style flags (), which Clang understands;
	# unfortunately, CMake passes these flags to all compilers under the
	# assumption they support the same syntax, but `swiftc` _only_ understands
	# Clang-style flags (`-Xlinker -foo`). In order to pass `LDFLAGS` in, we
	# have to turn them into a format that `swiftc` will understand.
	#
	# We can do this because we know we're compiling with Clang specifically.
	export LDFLAGS="$(clang-ldflags)"
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
		--preset=gentoo \
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
	# filesystem; we'll install the output versioned into `/usr/lib64` and
	# expose the relevant binaries via linking.
	local dest_dir="/usr/lib64/${P}"
	mkdir -p "${ED}/${dest_dir}" \
		&& cp -pPR "${S}/${P}/." "${ED}/${dest_dir}" \
		|| die

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

pkg_postinst() {
	# If we're installing the latest version of Swift, then update symlinks to
	# it. (We don't want to call `eselect swift update` unconditionally in case
	# we're installing an older version of Swift, and the user has intentionally
	# selected a version other than the latest.)
	if ! has_version ">${CATEGORY}/${P}"; then
		eselect swift update
	fi
}

pkg_postrm() {
	# We don't want to leave behind symlinks pointing to this Swift version on
	# removal.
	local eselect_swift_version="$(eselect swift show)"
	if [[ "${eselect_swift_version}" == *"${P}" ]]; then
		eselect swift update
	fi
}
