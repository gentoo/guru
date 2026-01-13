EAPI=8

inherit meson

# check if submodule commit needs to be updated on each xsystem4 update
LIBSYS4_COMMIT="6adc519d11a63df266902abf2d8e755d23894709"

DESCRIPTION="Cross-platform implementation of AliceSoft's System 4 game engine"
HOMEPAGE="https://github.com/nunuhara/xsystem4"
SRC_URI="
	https://github.com/nunuhara/xsystem4/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/nunuhara/libsys4/archive/${LIBSYS4_COMMIT}.tar.gz -> libsys4-${LIBSYS4_COMMIT}.tar.gz
"

#libsys4 submodule uses the same license
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug gles2"

RDEPEND="
	dev-libs/cglm
	dev-libs/libffi
	media-libs/freetype:2
	media-libs/libpng
	media-libs/libsndfile
	media-libs/libsdl2
	media-libs/libwebp
	virtual/zlib:=
	media-libs/libjpeg-turbo
	>=media-video/ffmpeg-5.1
	gles2? (
		media-libs/mesa
	)
	!gles2? (
		virtual/opengl
		media-libs/glew:0=
	)
	debug? (
		dev-scheme/chibi
	)
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	sys-devel/bison
	sys-devel/flex
	dev-build/meson
	dev-build/ninja
	virtual/pkgconfig
"

src_unpack() {
	default

	rmdir "${S}"/subprojects/libsys4 || die
	mv "${WORKDIR}"/libsys4-${LIBSYS4_COMMIT}/ "${S}"/subprojects/libsys4 || die
}

src_prepare() {
	sed -i "s/'git', 'describe', 'HEAD'/'echo', '${PV}'/" src/meson.build || die
	default
}

src_configure() {
	local emesonargs=(
		$(meson_feature debug debugger)
		$(meson_feature gles2 opengles)

		# Workaround for unaligned memory access with cglm+AVX
		# See: https://github.com/nunuhara/xsystem4/issues/294
		-Dc_args="-DCGLM_ALL_UNALIGNED"
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	# Documentation is installed automatically by meson
	# (shaders/, fonts/, debugger.scm are installed to datadir/xsystem4)

	dodoc README.md game_compatibility.md
}
