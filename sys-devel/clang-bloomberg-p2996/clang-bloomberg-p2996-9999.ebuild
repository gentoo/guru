# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 prefix python-utils-r1

DESCRIPTION="Clang fork implementing experimental support for P2996 (Reflection for C++26)"
HOMEPAGE="https://github.com/bloomberg/clang-p2996"

LICENSE="Apache-2.0-with-LLVM-exceptions UoI-NCSA BSD MIT public-domain rc"
SLOT="0"
KEYWORDS=""

EGIT_REPO_URI="https://github.com/bloomberg/clang-p2996.git"
EGIT_BRANCH="p2996"

ALL_LLVM_TARGETS="AArch64 AMDGPU ARC ARM AVR BPF CSKY DirectX Hexagon Lanai LoongArch M68k MSP430 Mips NVPTX PowerPC RISCV SPIRV Sparc SystemZ VE WebAssembly +X86 XCore Xtensa"
IUSE="+debug +default-reflection-latest +pie"
for target in ${ALL_LLVM_TARGETS}; do
	IUSE+=" ${target%${target#+}}llvm_targets_${target#+}"
done

# TODO
RDEPEND="sys-libs/zlib:0="
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/unknown-reflection.patch"
	"${FILESDIR}/uninitialized.patch"
)

CMAKE_USE_DIR="$S/llvm"

src_prepare() {
	# create extra parent dir for relative CLANG_RESOURCE_DIR access
	mkdir -p x/y || die
	BUILD_DIR=${WORKDIR}/x/y/clang

	use default-reflection-latest && eapply "${FILESDIR}/enable-reflection-latest.patch"

	cmake_src_prepare

	# add Gentoo Portage Prefix for Darwin (see prefix-dirs.patch)
	eprefixify \
		clang/lib/Lex/InitHeaderSearch.cpp \
		clang/lib/Driver/ToolChains/Darwin.cpp || die

	if ! use prefix-guest && [[ -n ${EPREFIX} ]]; then
		sed -i "/LibDir.*Loader/s@return \"\/\"@return \"${EPREFIX}/\"@" clang/lib/Driver/ToolChains/Linux.cpp || die
	fi
}

src_configure() {
	local targets=()
	for target in ${ALL_LLVM_TARGETS}; do
		use llvm_targets_${target#+} && targets+=("${target#+}")
	done
	if [ ${#targets[@]} -eq 0 ]; then
		die "At least one LLVM target must be enabled"
	fi

	local libdir=$(get_libdir)
	local mycmakeargs=(
		-DDEFAULT_SYSROOT=$(usex prefix-guest "" "${EPREFIX}")
		-DCMAKE_CXX_COMPILER_TARGET="${CHOST}"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr/lib/llvm/bloomberg-p2996"
		-DLLVM_LIBDIR_SUFFIX=${libdir#lib}

		-DBUILD_SHARED_LIBS=OFF
		-DLLVM_HOST_TRIPLE="${CHOST}"
		-DLLVM_BUILD_LLVM_DYLIB=ON
		-DLLVM_LINK_LLVM_DYLIB=ON
		-DLLVM_ENABLE_PROJECTS="clang"
		-DLLVM_ENABLE_RUNTIMES="libcxxabi;libcxx"
		-DLLVM_TARGETS_TO_BUILD="$(IFS=';'; echo "${targets[*]}")"
		-DLLVM_INCLUDE_BENCHMARKS=OFF
		-DLLVM_INCLUDE_TESTS=OFF
		-DLLVM_BUILD_TESTS=OFF
		-DLLVM_INSTALL_GTEST=OFF

		-DLLVM_ENABLE_ASSERTIONS=$(usex debug)
		-DLLVM_ENABLE_EH=ON
		-DLLVM_ENABLE_RTTI=ON
		-DLLVM_ENABLE_ZLIB=FORCE_ON

		-DLIBCXX_ENABLE_SHARED=ON
		-DLIBCXX_ENABLE_STATIC=OFF
		-DLIBCXX_CXX_ABI=libcxxabi
		-DLIBCXX_USE_COMPILER_RT=OFF
		-DLIBCXX_HAS_GCC_S_LIB=OFF
		-DLIBCXX_INCLUDE_BENCHMARKS=OFF
		-DLIBCXX_INCLUDE_TESTS=OFF
		-DLIBCXXABI_LIBUNWIND_INCLUDES="${EPREFIX}"/usr/include
		-DLIBCXXABI_USE_LLVM_UNWINDER=OFF

		-DCLANG_CONFIG_FILE_SYSTEM_DIR="${EPREFIX}/etc/clang/bloomberg-p2996"
		-DCLANG_CONFIG_FILE_USER_DIR="~/.config/clang"
		# relative to bindir
		-DCLANG_RESOURCE_DIR="../../../../lib/clang/bloomberg-p2996"
		-DCLANG_LINK_CLANG_DYLIB=ON
		-DCLANG_INCLUDE_TESTS=OFF

		-DCLANG_DEFAULT_OPENMP_RUNTIME=libomp
		-DCLANG_DEFAULT_PIE_ON_LINUX=$(usex pie)

		-DPython3_EXECUTABLE="${PYTHON}"

		-DOCAMLFIND=NO
	)

	use debug || local -x CPPFLAGS="${CPPFLAGS} -DNDEBUG"
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

_doclang_cfg() {
	local triple="${1}"

	local tool
	for tool in clang{,++,-cpp}; do
		newins - "${triple}-${tool}.cfg" <<-EOF
			# This configuration file is used by ${triple}-${tool} driver.
			@../${triple}-${tool}.cfg
			@gentoo-plugins.cfg
			@gentoo-runtimes.cfg
		EOF

		if [[ ! -f "${ED}/etc/clang/bloomberg-p2996/bloomberg-p2996-${tool}.cfg" ]]; then
			dosym "${triple}-${tool}.cfg" "/etc/clang/bloomberg-p2996/bloomberg-p2996-${tool}.cfg"
		fi
	done

	# Install symlinks for triples with other vendor strings since some
	# programs insist on mangling the triple.
	local vendor
	for vendor in gentoo pc unknown; do
		local vendor_triple="${triple%%-*}-${vendor}-${triple#*-*-}"
		for tool in clang{,++,-cpp}; do
			if [[ ! -f "${ED}/etc/clang/bloomberg-p2996/${vendor_triple}-${tool}.cfg" ]]; then
				dosym "${triple}-${tool}.cfg" "/etc/clang/bloomberg-p2996/${vendor_triple}-${tool}.cfg"
			fi
		done
	done
}

doclang_cfg() {
	#local triple=$(get_abi_CHOST "${abi}")
	local triple=${CHOST}

	_doclang_cfg ${triple}

	# LLVM may have different arch names in some cases. For example in x86
	# profiles the triple uses i686, but llvm will prefer i386 if invoked
	# with "clang" on x86 or "clang -m32" on x86_64. The gentoo triple will
	# be used if invoked through ${CHOST}-clang{,++,-cpp} though.
	#
	# To make sure the correct triples are installed,
	# see Triple::getArchTypeName() in llvm/lib/TargetParser/Triple.cpp
	# and compare with CHOST values in profiles.

	local abi=${triple%%-*}
	case ${abi} in
		armv4l|armv4t|armv5tel|armv6j|armv7a)
			_doclang_cfg ${triple/${abi}/arm}
			;;
		i686)
			_doclang_cfg ${triple/${abi}/i386}
			;;
		sparc)
			_doclang_cfg ${triple/${abi}/sparcel}
			;;
		sparc64)
			_doclang_cfg ${triple/${abi}/sparcv9}
			;;
	esac
}

src_install() {
	cmake_src_install

	# Rename programs and update symlinks
	cd "${D}/usr/lib/llvm/bloomberg-p2996/bin" || die
	for file in *; do
		if [[ -f "${file}" && -x "${file}" && ! -L "${file}" ]]; then
			# Rename regular, executable files
			mv "${file}" "bloomberg-p2996-${file}" || die "Failed to rename ${file}"
		elif [[ -L "${file}" ]]; then
			# Update symlink to point to renamed target
			local target
			target=$(readlink "${file}") || die "Failed to read symlink ${file}"
			ln -sf "bloomberg-p2996-${target}" "bloomberg-p2996-${file}" || die "Failed to update symlink ${file}"
			rm "${file}" || die "Failed to remove original symlink ${file}"
		fi
	done

	local ldpath="${EPREFIX}/usr/lib/llvm/bloomberg-p2996/$(get_libdir)"
	newenvd - "60llvm-bloomberg-p2996" <<-_EOF_
		PATH="${EPREFIX}/usr/lib/llvm/bloomberg-p2996/bin"
		# we need to duplicate it in ROOTPATH for Portage to respect...
		ROOTPATH="${EPREFIX}/usr/lib/llvm/bloomberg-p2996/bin"
		LDPATH="${ldpath}:${ldpath}/${CHOST}"
	_EOF_

	insinto "/etc/clang/bloomberg-p2996"
	newins - gentoo-runtimes.cfg <<-EOF
		# This file is initially generated by sys-devel/clang-bloomberg-p2996::guru.
		# It is used to control the default runtimes using by clang.

		--rtlib=libgcc
		--unwindlib=libgcc
		--stdlib=libc++
		-fuse-ld=bfd
		-L${ldpath}/${CHOST}
	EOF
	newins - gentoo-plugins.cfg <<-EOF
		# This file is used to load optional LLVM plugins.
	EOF

	doclang_cfg

	rm -r "${D}/usr/share/man" || die
}

pkg_postinst() {
	elog "Binaries are installed with a 'bloomberg-p2996-' prefix,"
	elog "e.g.: bloomberg-p2996-clang++"
	use default-reflection-latest && \
		elog "Pass -fno-reflection-latest to disable reflection support." || \
		elog "Pass -freflection-latest to enable reflection support."
}
