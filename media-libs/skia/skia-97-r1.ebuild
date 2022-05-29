# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit ninja-utils python-any-r1 toolchain-funcs

#https://github.com/google/skia/blob/master/include/core/SkMilestone.h
COMMIT="f2093bf1b076210bd017f237eaab84ea4d3d6771"

DESCRIPTION="A complete 2D graphic library for drawing Text, Geometries, and Images"
HOMEPAGE="
	https://skia.org
	https://github.com/google/skia
"
SRC_URI="https://github.com/google/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"
IUSE="+ccpr debug ffmpeg +fontconfig +freetype gpu +harfbuzz +icu jit +jpeg +lottie lua opencl +opengl +pdf +png +rive svg vulkan +webp +zlib +X +xml"
#TODO: find out how to enable and link: angle dawn piex sfntly wuffs

CDEPEND="
	media-libs/skcms:=

	ffmpeg? ( media-video/ffmpeg )
	fontconfig? ( media-libs/fontconfig )
	freetype? ( media-libs/freetype )
	harfbuzz? ( media-libs/harfbuzz:=[icu?] )
	icu? ( dev-libs/icu:= )
	jpeg? ( media-libs/libjpeg-turbo )
	lua? ( dev-lang/lua:* )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )
	webp? ( media-libs/libwebp )
	xml? ( dev-libs/expat )
	zlib? ( sys-libs/zlib )
"
RDEPEND="
	${CDEPEND}
	opencl? ( virtual/opencl )
"
DEPEND="
	${PYTHON_DEPS}
	${CDEPEND}
	opencl? ( dev-util/opencl-headers )
	vulkan? ( dev-util/vulkan-headers )
"
BDEPEND="dev-util/gn"

PATCHES=(
	"${FILESDIR}/${P}-system-skcms-headers.patch"
	"${FILESDIR}/${P}-system-skcms.patch"
	"${FILESDIR}/${P}-system-vulkan.patch"
	"${FILESDIR}/${P}-questionable-flags.patch"
	"${FILESDIR}/${P}-system-zlib.patch"
)

REQUIRED_USE="
	X? ( opengl )
"

src_prepare() {
	rm -r include/third_party/* || die
	rm -r third_party/skcms || die

	default
}

src_configure() {
	python_setup
	tc-export AR CC CXX

	local myconf_gn=()
	passflags() {
		local _f _x
		_f=( ${1} )
		_x="[$(printf '"%s", ' "${_f[@]}")]"
		myconf_gn+=( extra_${2}="${_x}" )
	}
	passflags "${CFLAGS}" cflags_c
	passflags "${CXXFLAGS}" cflags_cc
	passflags "${LDFLAGS}" ldflags

	# skia_qt_path = getenv("QT_PATH") #todo

	myconf_gn+=(
		ar=\"${AR}\"
		cc=\"${CC}\"
		cxx=\"${CXX}\"
		is_component_build=true
		is_official_build=true
		is_shared_library=true
		skia_build_fuzzers=false
		skia_compile_processors = true
		skia_compile_sksl_tests=false
		skia_enable_android_utils=false #android
		skia_enable_api_available_macro = true
		skia_enable_flutter_defines = false
		skia_enable_fontmgr_android=false #android
		skia_enable_fontmgr_win_gdi=false #windows
		skia_enable_nga=false
		skia_enable_tools=false
		skia_enable_winuwp = false
		skia_generate_workarounds = false
		skia_include_multiframe_procs = false
		skia_lex = false
		skia_skqp_global_error_tolerance=0
		skia_update_fuchsia_sdk=false #fuchsia
		skia_use_angle=false #todo
		skia_use_dawn=false #todo
		skia_use_direct3d=false #windows
		skia_use_dng_sdk=false
		skia_use_libheif=false #android only
		skia_use_experimental_xform=false
		skia_use_fixed_gamma_text=false #android
		skia_use_fonthost_mac=false #mac
		skia_use_libgifcodec=false #todo
		skia_use_metal=false #ios
		skia_use_ndk_images=false #android
		skia_use_piex=false #todo
		skia_use_sfml=false #todo
		skia_use_sfntly=false #todo
		skia_use_webgl=false #todo
		skia_use_wuffs=false #todo
		skia_use_xps=false #windows

		skia_enable_ccpr=$(usex ccpr true false)
		skia_enable_gpu=$(usex gpu true false)
		skia_enable_gpu_debug_layers=$(usex debug true false)
		skia_enable_pdf=$(usex pdf true false)
		skia_enable_skottie=$(usex lottie true false)
		skia_enable_skrive=$(usex rive true false)
		skia_enable_skvm_jit_when_possible=$(usex jit true false)
		skia_enable_svg=$(usex svg true false)
		skia_pdf_subset_harfbuzz =$(usex harfbuzz true false)
		skia_use_egl=$(usex opengl true false)
		skia_use_expat=$(usex xml true false)
		skia_use_ffmpeg=$(usex ffmpeg true false)
		skia_use_fontconfig=$(usex fontconfig true false)
		skia_use_gl=$(usex opengl true false)
		skia_use_harfbuzz=$(usex harfbuzz true false)
		skia_use_icu=$(usex icu true false)
		skia_use_libjpeg_turbo_decode=$(usex jpeg true false)
		skia_use_libjpeg_turbo_encode=$(usex jpeg true false)
		skia_use_libpng_decode=$(usex png true false)
		skia_use_libpng_encode=$(usex png true false)
		skia_use_libwebp_decode=$(usex webp true false)
		skia_use_libwebp_encode=$(usex webp true false)
		skia_use_lua=$(usex lua true false)
		skia_use_opencl=$(usex opencl true false)
		skia_use_vma=$(usex vulkan true false)
		skia_use_vulkan=$(usex vulkan true false)
		skia_use_x11=$(usex X true false)
		skia_use_zlib=$(usex zlib true false)
	)

		if use freetype; then
			myconf_gn+=( skia_enable_fontmgr_custom_directory=true )
			myconf_gn+=( skia_enable_fontmgr_custom_embedded=true )
			myconf_gn+=( skia_enable_fontmgr_custom_empty=true )
			myconf_gn+=( skia_use_freetype=true )
			myconf_gn+=( skia_use_system_freetype2=true )

			if use fontconfig; then
				myconf_gn+=( skia_enable_fontmgr_fontconfig=true )
				myconf_gn+=( skia_enable_fontmgr_FontConfigInterface=true )
			fi
		else
			myconf_gn+=( skia_enable_fontmgr_custom_directory=false )
			myconf_gn+=( skia_enable_fontmgr_custom_embedded=false )
			myconf_gn+=( skia_enable_fontmgr_custom_empty=false )
			myconf_gn+=( skia_use_freetype=false )
			myconf_gn+=( skia_use_system_freetype2=false )
		fi

		if ! use freetype !! ! use fontconfig; then
			myconf_gn+=( skia_enable_fontmgr_fontconfig=false )
			myconf_gn+=( skia_enable_fontmgr_FontConfigInterface=false )
		fi

#		skia_use_angle=$(usex angle true false)
#		skia_use_piex=$(usex piex true false)
#		skia_use_sfntly=$(usex sfntly true false)
#		skia_use_wuffs=$(usex wuffs true false)

	use harfbuzz	&& myconf_gn+=( skia_use_system_harfbuzz=true )
	use icu		&& myconf_gn+=( skia_use_system_icu=true )
	use jpeg	&& myconf_gn+=( skia_use_system_libjpeg_turbo=true )
	use lua		&& myconf_gn+=( skia_use_system_lua=true )
	use png		&& myconf_gn+=( skia_use_system_libpng=true )
	use webp	&& myconf_gn+=( skia_use_system_libwebp=true )
	use zlib	&& myconf_gn+=( skia_use_system_zlib=true )

	myconf_gn="${myconf_gn[@]} ${EXTRA_GN}"
	set -- gn gen --args="${myconf_gn% }" out/Release || die
	echo "$@"
	"$@" || die
}

src_compile() {
	eninja -C out/Release
}

src_install() {
	dolib.so out/Release/*.so
	insinto "/usr/include/${PN}"
	doins -r include/.
}
