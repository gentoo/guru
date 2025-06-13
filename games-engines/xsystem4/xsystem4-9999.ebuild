EAPI=8

inherit git-r3 meson

DESCRIPTION="Cross-platform implementation of AliceSoft's System 4 game engine"
HOMEPAGE="https://github.com/nunuhara/xsystem4"
EGIT_REPO_URI="https://github.com/nunuhara/xsystem4.git"
EGIT_SUBMODULES=( '*' )

LICENSE="GPL-2"
SLOT="0"
IUSE="debug gles2"

RDEPEND="
	dev-libs/cglm
	dev-libs/libffi
	media-libs/freetype:2
	media-libs/libpng
	media-libs/libsndfile
	media-libs/libsdl2
	media-libs/libwebp
	sys-libs/zlib
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

src_configure() {
	local emesonargs=(
		$(meson_feature debug debugger)
		$(meson_feature gles2 opengles)
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	# Documentation is installed automatically by meson
	# (shaders/, fonts/, debugger.scm are installed to datadir/xsystem4)

	dodoc README.md game_compatibility.md
}
