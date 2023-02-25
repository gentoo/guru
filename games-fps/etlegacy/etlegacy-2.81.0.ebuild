# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake unpacker xdg

DESCRIPTION="Wolfenstein: Enemy Territory 2.60b compatible client/server"
HOMEPAGE="https://www.etlegacy.com/"

# We need the game files from the original enemy-territory release
ET_RELEASE="et260b"
SRC_URI="https://cdn.splashdamage.com/downloads/games/wet/${ET_RELEASE}.x86_full.zip"

if [[ ${PV} = "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://github.com/${PN}/${PN}.git"
else
	SRC_URI+=" https://github.com/${PN}/${PN}/archive/v${PV/_rc/rc}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3 RTCW-ETEULA"
SLOT="0"
IUSE="autoupdate +curl dedicated +freetype +gettext ipv6 irc +lua omnibot +openal +opengl +png renderer2 renderer-gles +ssl +theora +vorbis"
#REQUIRED_USE="omnibot? ( x86 )"

RESTRICT="bindist mirror"

# TODO add debug use for CMAKE_BUILD_TYPE=debug

LUADEPEND="lua? ( >=dev-lang/lua-5.4:* )"

# * media-libs/glew     | media-libs/glew:=
# * media-libs/libpng:= <
# *                     > media-libs/libogg
# * media-libs/openal   <
# * sys-devel/gettext   <
UIDEPEND="
	media-libs/glew:=
	media-libs/libsdl2[sound,video,X]
	media-libs/libogg
	media-libs/libjpeg-turbo:0
	virtual/opengl
	sys-libs/zlib:=[minizip]
	curl? ( net-misc/curl )
	freetype? ( media-libs/freetype )
	gettext? ( sys-devel/gettext )
	renderer-gles? ( media-libs/mesa[gles1] )
	openal? ( media-libs/openal )
	png? ( media-libs/libpng:0= )
	ssl? ( dev-libs/openssl:0= )
	theora? ( media-libs/libtheora )
	vorbis? ( media-libs/libvorbis )
	${LUADEPEND}
"

DEPEND="
	dev-db/sqlite:3
	dev-libs/cJSON
	opengl? ( ${UIDEPEND} )
"

RDEPEND="${DEPEND}"
BDEPEND="$(unpacker_src_uri_depends)"

#QA_TEXTRELS="usr/share/games/etlegacy/legacy/omni-bot/omnibot_et.so"

S="${WORKDIR}/${P/_rc/rc}"

src_unpack() {
	if [[ "${PV}" = 9999 ]] ; then
		git-r3_src_unpack
	else
		default
	fi
	mkdir et && cd et || die
	unzip "${DISTDIR}"/${ET_RELEASE}.x86_full.zip
	unpack_makeself ${ET_RELEASE}.x86_keygen_V03.run
}

src_prepare() {
	cmake_src_prepare
	# if [[ "${PV}" != 9999 ]] ; then
	# 	sed -e "/^set(ETLEGACY_VERSION_MINOR/s@[[:digit:]]\+@$(ver_cut 2)@" \
	# 		-i cmake/ETLVersion.cmake || die
	# fi
	sed -e 's@[-_]dirty@@' -i cmake/ETLVersion.cmake || die
}

src_configure() {
	mycmakeargs=(
		# path and build type
		#-DCMAKE_BUILD_TYPE="Release"
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DINSTALL_DEFAULT_BASEDIR="/usr/share/${PN}"
		-DINSTALL_DEFAULT_BINDIR="/usr/bin"
		-DINSTALL_DEFAULT_MODDIR="/usr/share/${PN}"
		-DCMAKE_LIBRARY_PATH="/usr/$(get_libdir)"
		-DCMAKE_INCLUDE_PATH="/usr/include"
		-DDOCDIR="${EPREFIX}/usr/share/doc/${PF}"
		-DCROSS_COMPILE32="0"
		# what to build
		-DBUILD_CLIENT="$(usex opengl)"
		-DBUILD_MOD="1"
		-DBUILD_MOD_PK3="1"
		-DBUILD_SERVER="$(usex dedicated)"
		# no bundled libs
		-DBUNDLED_LIBS="0"
		-DBUNDLED_LIBS_DEFAULT="0"
		#-DBUNDLED_SDL="0"
		#-DBUNDLED_CURL="0"
		#-DBUNDLED_JPEG="0"
		#-DBUNDLED_LUA="0"
		#-DBUNDLED_OGG_VORBIS="0"
		#-DBUNDLED_GLEW="0"
		#-DBUNDLED_FREETYPE="0"
		# features
		-DFEATURE_CURL="$(usex curl)"
		-DFEATURE_SSL="$(usex ssl)"
		-DFEATURE_OGG_VORBIS="$(usex vorbis)"
		-DFEATURE_THEORA="$(usex theora)"
		-DFEATURE_OPENAL="$(usex openal)"
		-DFEATURE_FREETYPE="$(usex freetype)"
		-DFEATURE_PNG="$(usex png)"
		-DFEATURE_LUA="$(usex lua)"
		-DFEATURE_IRC_CLIENT="$(usex irc)"
		-DFEATURE_IPV6="$(usex ipv6)"
		-DFEATURE_GETTEXT="$(usex gettext)"
		-DFEATURE_ANTICHEAT="1"
		-DFEATURE_AUTOUPDATE="$(usex autoupdate)"
		# renderers
		-DFEATURE_RENDERER2="$(usex renderer2 ON OFF)"
		-DFEATURE_RENDERER_GLES="$(usex renderer-gles)"

		-DFEATURE_OMNIBOT="$(usex omnibot)"
		-DINSTALL_OMNIBOT="$(usex omnibot)"
		-DINSTALL_GEOIP="0"
		-DINSTALL_WOLFADMIN="0"
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	local arch=$(uname -m || die "Failed to detect architecture")

	insinto /usr/share/etlegacy/legacy
	doins "${BUILD_DIR}"/legacy/ui.mp.${arch}.so

	# Install the game files
	insinto /usr/share/etlegacy/etmain
	doins "${WORKDIR}"/et/etmain/pak[012].pk3
}
