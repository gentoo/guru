# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..14} )

inherit cmake python-any-r1 check-reqs linux-info

DESCRIPTION="Translation layer for running macOS software on Linux"
HOMEPAGE="https://www.darlinghq.org"

SRC_URI="
	https://github.com/darlinghq/darling/releases/download/v0.1.20260222/darling-source.tar.gz -> darling-complete-source-${PV}.tar.gz
"

S="${WORKDIR}/darling"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cli cli_dev cli_extra gui gui_frameworks gui_stubs jsc webkit python ruby perl metal multilib system"

REQUIRED_USE="
	cli_dev?		( cli python ruby perl )
	cli?			( system )
	cli_extra?		( cli )
	gui_frameworks?	( gui )
	gui_stubs?		( gui_frameworks )
	gui?			( system )
	webkit?			( jsc )
	python?			( system )
	ruby?			( system )
	perl?			( system )
	metal?			( gui )
"

DEPEND="
	x11-misc/xdg-user-dirs
	sys-fs/fuse:0
	dev-libs/icu:=
	dev-libs/libbsd
	dev-libs/libxml2:2
	llvm-core/llvm:=
	media-libs/freetype
	media-libs/libjpeg-turbo
	media-libs/fontconfig
	media-libs/tiff:=
	multilib? (
		media-libs/freetype[abi_x86_32]
		media-libs/libjpeg-turbo[abi_x86_32]
		media-libs/fontconfig[abi_x86_32]
		media-libs/tiff[abi_x86_32]
		sys-libs/glibc[multilib]
	)

	gui? (
		media-libs/mesa[X]
		virtual/opengl
		virtual/glu
		media-libs/libpng:=
		media-libs/giflib:=
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrandr
		x11-libs/libXcursor
		x11-libs/libxkbfile
		x11-libs/cairo
		media-libs/libpulse
		media-libs/vulkan-loader
	)
	gui? ( multilib? (
		media-libs/mesa[X,abi_x86_32]
		virtual/opengl[abi_x86_32]
		virtual/glu[abi_x86_32]
	) )

	sys-apps/dbus
	media-video/ffmpeg:=
"

BDEPEND="
	>=llvm-core/clang-11
	sys-devel/flex
	sys-devel/bison
	dev-build/cmake
	virtual/pkgconfig
	llvm-core/llvm:=
	${PYTHON_DEPS}
	gui? ( dev-util/vulkan-headers )
"

RDEPEND="${DEPEND}"

QA_SONAME="*"

pkg_pretend(){
	# https://unix.stackexchange.com/questions/131954/check-sse3-support-from-bash
	if ! grep -qE '^flags.* (sse3|pni)' /proc/cpuinfo; then
		eerror "darling requires a cpu with support of the sse3 instruction set"
		die "cpu doesn't support sse3 instruction set"
	fi

	if kernel_is -lt 5 0; then
		eerror "darling requires Linux kernel 5.0 or newer to be installed"
		die "darling requires Linux kernel 5.0 or newer"
	fi

	CHECKREQS_DISK_BUILD="16G"
	CHECKREQS_MEMORY="4G"

	check-reqs_pkg_pretend
}

pkg_setup(){
	# https://unix.stackexchange.com/questions/131954/check-sse3-support-from-bash
	if ! grep -qE '^flags.* (sse3|pni)' /proc/cpuinfo; then
		eerror "darling requires a cpu with support of the sse3 instruction set"
		die "cpu doesn't support sse3 instruction set"
	fi

	if kernel_is -lt 5 0; then
		eerror "darling requires Linux kernel 5.0 or newer to be installed"
		die "darling requires Linux kernel 5.0 or newer"
	fi

	CHECKREQS_DISK_BUILD="16G"
	CHECKREQS_MEMORY="4G"

	check-reqs_pkg_setup
	python-any-r1_pkg_setup
}

src_prepare() {
	default

	cd "${S}"

	# We need clang as we're building a Darwin system
	export CC=clang
	export CXX=clang++

	unset LDFLAGS
	export LDFLAGS=""

	cmake_src_prepare

}

src_configure() {
	export CC=clang
	export CXX=clang++

	unset LDFLAGS
	export LDFLAGS=""

	local components="core"

	use system			&& components+=",system"
	use python			&& components+=",python"
	use ruby			&& components+=",ruby"
	use perl			&& components+=",perl"
	use cli				&& components+=",cli"
	use cli_dev			&& components+=",cli_dev"
	use cli_extra		&& components+=",cli_extra"
	use gui				&& components+=",gui"
	use gui_frameworks	&& components+=",gui_frameworks"
	use gui_stubs		&& components+=",gui_stubs"
	use jsc				&& components+=",jsc"
	use webkit			&& components+=",webkit"

	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=/usr"
		"-DCMAKE_POSITION_INDEPENDENT_CODE=ON"
		"-DDARLING_COMPONENTS=\"${components}\""
		"-DJSC_UNIFIED_BUILD=ON"
		"-DENABLE_METAL=$(usex metal ON OFF)"
		"-DTARGET_i386=$(usex multilib ON OFF)"
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install

	# Darlingserver requires these empty dirs to exist at runtime
	# to set up its container (procfs mount, tmp, var, etc.)
	keepdir /usr/libexec/darling/private/tmp
	keepdir /usr/libexec/darling/private/var
	keepdir /usr/libexec/darling/private/etc
	keepdir /usr/libexec/darling/proc
	keepdir /usr/libexec/darling/run
}
