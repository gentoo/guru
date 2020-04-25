# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python2_7 )

inherit ninja-utils python-any-r1

#https://github.com/google/skia/blob/master/include/core/SkMilestone.h
COMMIT="93e853bf2b832d13cb64194b90a8fec44544e518"

SRC_URI="https://github.com/google/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
DESCRIPTION="A complete 2D graphic library for drawing Text, Geometries, and Images"
HOMEPAGE="
	https://skia.org
	https://github.com/google/skia
"
LICENSE="BSD"
SLOT="0"
IUSE="dawn expat gif jpeg png pdf webp zlib"
#TODO: find out how to enable and link: angle egl ffmpeg fontconfig freetype gl harfbuzz heif icu lua opencl piex sfntly wuffs vulkan xps s

#TODO: find out which deps are needed for gl/egl/vulkan/X/gif/xps
#	fontconfig? ( media-libs/fontconfig )
#	freetype? ( media-libs/freetype )
#	ffmpeg? ( virtual/ffmpeg )
#	harfbuzz? ( media-libs/harfbuzz )
#	heif? ( media-libs/libheif )
#	icu? ( dev-libs/icu )
#	virtual/opengl
#	lua? ( dev-lang/lua )
#	opencl? ( virtual/opencl )
RDEPEND="
	expat? ( dev-libs/expat )
	jpeg? ( media-libs/libjpeg-turbo )
	png? ( media-libs/libpng )
	webp? ( media-libs/libwebp )
	zlib? ( sys-libs/zlib )
"
DEPEND="
	${PYTHON_DEPS}
	${RDEPEND}
"
BDEPEND="
	dev-util/gn
"

S="${WORKDIR}/${PN}-${COMMIT}"

src_prepare() {
	default
	# https://chromium.googlesource.com/chromium/src/third_party/zlib
	# https://github.com/jtkukunas/zlib
	sed \
		-e '/:zlib_x86/d' \
		-e '/third_party("zlib_x86/,/^}/d' \
		-i third_party/zlib/BUILD.gn
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
	passflags "${CFLAGS}" ldflags

	myconf_gn+=(
		ar=\"${AR}\"
		cc=\"${CC}\"
		cxx=\"${CXX}\"
		is_component_build=true
		is_official_build=true

		skia_enable_pdf=$(usex pdf true false)

		skia_use_dawn=$(usex dawn true false)
		skia_use_expat=$(usex expat true false)
		skia_use_libgifcodec=$(usex gif true false)
		skia_use_libjpeg_turbo_decode=$(usex jpeg true false)
		skia_use_libjpeg_turbo_encode=$(usex jpeg true false)
		skia_use_libpng_decode=$(usex png true false)
		skia_use_libpng_encode=$(usex png true false)
		skia_use_libwebp_decode=$(usex webp true false)
		skia_use_libwebp_encode=$(usex webp true false)
		skia_use_zlib=$(usex zlib true false)

		skia_use_direct3d=false
		skia_use_dng_sdk=false
		skia_use_fonthost_mac=false
		skia_use_metal=false
	)
#		skia_use_angle=$(usex angle true false)
#		skia_use_egl=$(usex egl true false)
#		skia_use_fontconfig=$(usex fontconfig true false)
#		skia_use_freetype=$(usex freetype true false)
#		skia_use_ffmpeg=$(usex ffmpeg  true false)
#		skia_use_gl=$(usex gl true false)
#		skia_use_harfbuzz=$(usex harfbuzz true false)
#		skia_use_icu=$(usex icu true false)
#		skia_use_libheif=$(usex heif true false)
#		skia_use_lua=$(usex lua true false)
#		skia_use_opencl=$(usex opencl true false)
#		skia_use_vulkan=$(usex vulkan true false)
#		skia_use_x11=$(usex X true false)
#		skia_use_xps=$(usex xps true false)
#		skia_use_piex=$(usex piex true false)
#		skia_use_sfntly=$(usex sfntly true false)
#		skia_use_wuffs=$(usex wuffs true false)

#	use freetype	&& myconf_gn+=( skia_use_system_freetype2=true )
#	use harfbuzz	&& myconf_gn+=( skia_use_system_harfbuzz=true )
#	use icu		&& myconf_gn+=( skia_use_system_icu=true )
	use jpeg	&& myconf_gn+=( skia_use_system_libjpeg_turbo=true )
#	use lua		&& myconf_gn+=( skia_use_system_lua=true )
	use png		&& myconf_gn+=( skia_use_system_libpng=true )
	use webp	&& myconf_gn+=( skia_use_system_libwebp=true )
	use zlib	&& myconf_gn+=( skia_use_system_zlib=true )

	myconf_gn="${myconf_gn[@]} ${EXTRA_GN}"
	set -- gn gen --args="${myconf_gn% }" out/Release
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
