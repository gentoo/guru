# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Bloat-free graphical user interface library for C++"
HOMEPAGE="
	https://github.com/ocornut/imgui
	https://github.com/cimgui/cimgui
"
SRC_URI="
	https://github.com/ocornut/imgui/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/cimgui/cimgui/archive/refs/tags/${PV}.tar.gz -> c${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="allegro bindings examples freetype glfw glut opengl sdl vulkan"
S="${WORKDIR}/c${P}"

RDEPEND="
	dev-libs/stb:=
	allegro? ( media-libs/allegro:5 )
	freetype? ( media-libs/freetype )
	glfw? ( media-libs/glfw:0 )
	glut? ( media-libs/freeglut )
	opengl? ( virtual/opengl )
	sdl? ( media-libs/libsdl2 )
	vulkan? ( media-libs/vulkan-loader )
"
DEPEND="
	${RDEPEND}
	vulkan? ( dev-util/vulkan-headers )
"
BDEPEND="
	bindings? ( dev-lang/luajit )
	virtual/pkgconfig
"

REQUIRED_USE="
	|| (
		allegro
		glfw
		glut
		sdl
	)
	|| (
		allegro
		opengl
		vulkan
	)
"

PATCHES=( "${FILESDIR}/${P}-fpermissive.patch" )

src_prepare() {
	pushd ../ || die
	rm -rf "${S}/imgui" || die
	mv "${P}" "${S}/imgui" || die
	pushd "${S}/imgui" || die

	# imgui
	rm -r examples/libs || die
	rm -r misc/*/*.ttf || die
	rm -r misc/single_file || die

	cp "${FILESDIR}/${P}-CMakeLists.txt" CMakeLists.txt || die
	cp "${FILESDIR}/imgui.pc.in" imgui.pc.in || die
	sed -e "s|@version@|${PV}|g" -i imgui.pc.in || die

	pushd "${S}" || die
	cp "${FILESDIR}/c${P}-CMakeLists.txt" CMakeLists.txt || die
	# remove files to be generated
	rm cimgui.cpp cimgui.h generator/output/* || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DIMGUI_ALLEGRO=$(usex allegro)
		-DIMGUI_BINDINGS=$(usex bindings)
		-DIMGUI_EXAMPLES=$(usex examples)
		-DIMGUI_FREETYPE=$(usex freetype)
		-DIMGUI_GLFW=$(usex glfw)
		-DIMGUI_GLUT=$(usex glut)
		-DIMGUI_OPENGL=$(usex opengl)
		-DIMGUI_SDL=$(usex sdl)
		-DIMGUI_VULKAN=$(usex vulkan)
	)
	cmake_src_configure
}

src_install() {

	cmake_src_install

	pushd imgui || die
	# imgui
	rm -rf misc/{fonts,freetype} || die
	dodoc -r misc

	popd || die

	if use bindings; then
		# cimgui

		insinto "/usr/share/doc/${PF}/cimgui"
		doins README.md TODO.txt
	fi
}
