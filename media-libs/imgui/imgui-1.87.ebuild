# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Bloat-free graphical user interface library for C++"
HOMEPAGE="https://github.com/ocornut/imgui"
SRC_URI="https://github.com/ocornut/imgui/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="allegro examples freetype glfw glut opengl sdl vulkan"

RDEPEND="
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
BDEPEND="virtual/pkgconfig"

REQUIRED_USE="
	|| (
		allegro
		|| ( glfw glut sdl )
		|| ( opengl vulkan )
	)
	examples? (
		allegro
		glfw
		glut
		opengl
		sdl
		vulkan
	)
"

src_prepare() {
	rm -r examples/libs || die
	rm -r misc/*/*.ttf || die
	rm -r misc/single_file || die
	default
}

src_configure() {
	tc-export CXX
	append-cppflags "-DIMGUI_USE_WCHAR32"
	append-cxxflags "-I${S} -I${S}/backends -I${S}/misc/freetype -fPIC -fpermissive"
	local PKGCONF="$(tc-getPKG_CONFIG)" || die

	use allegro && append-libs "-lallegro -lallegro_main -lallegro_primitives"
	if use freetype; then
		append-cppflags "-DIMGUI_ENABLE_FREETYPE -DIMGUI_ENABLE_STB_TRUETYPE"
		append-cxxflags "$(${PKGCONF} --cflags freetype2)" || die
		append-libs "$(${PKGCONF} --libs freetype2)" || die
	fi
	if use glfw; then
		append-libs "$(${PKGCONF} --libs glfw3)" || die
		append-cxxflags "$(${PKGCONF} --cflags glfw3)" || die
	fi
	if use glut; then
		append-libs "$(${PKGCONF} --libs freeglut)" || die
		append-cxxflags "$(${PKGCONF} --cflags freeglut)" || die
	fi
	use opengl && append-libs "-lGL"
	if use sdl; then
		append-libs "-ldl $(sdl2-config --libs)" || die
		append-cxxflags "$(sdl2-config --cflags)" || die
	fi
	if use vulkan; then
		append-libs "$(${PKGCONF} --libs vulkan)" || die
		append-cxxflags "$(${PKGCONF} --cflags vulkan)" || die
		append-cppflags "-DImTextureID=ImU64" || die
	fi
}

src_compile() {
	set -x || die

	for i in imgui{,_draw,_demo,_tables,_widgets}; do
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -c ${i}.cpp -o ${i}.o || die
	done

	if use freetype; then
		pushd misc/freetype || die
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -c imgui_freetype.cpp -o imgui_freetype.o || die
		popd || die
		pushd misc/fonts || die
		${CXX} ${CXXFLAGS} ${CPPFLAGS} ${LDFLAGS} -fPIE binary_to_compressed_c.cpp -o binary_to_compressed_c || die
		popd || die
	fi

	pushd backends || die
	if use allegro; then
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -c imgui_impl_allegro5.cpp -o imgui_impl_allegro5.o || die
	fi
	if use glfw; then
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -c imgui_impl_glfw.cpp -o imgui_impl_glfw.o || die
	fi
	if use glut; then
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -c imgui_impl_glut.cpp -o imgui_impl_glut.o || die
	fi
	if use opengl; then
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -c imgui_impl_opengl2.cpp -o imgui_impl_opengl2.o || die
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -c imgui_impl_opengl3.cpp -o imgui_impl_opengl3.o || die
	fi
	if use sdl; then
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -c imgui_impl_sdl.cpp -o imgui_impl_sdl.o || die
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -c imgui_impl_sdlrenderer.cpp -o imgui_impl_sdlrenderer.o || die
	fi
	if use vulkan; then
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -c imgui_impl_vulkan.cpp -o imgui_impl_vulkan.o || die
	fi
	popd || die
	${CXX} ${CXXFLAGS} ${CPPFLAGS} ${LDFLAGS} -shared -Wl,-soname,libimgui.so *.o backends/*.o misc/freetype/*.o -o libimgui.so ${LIBS} || die

	if use examples; then
		mkdir ex || die
		for f in allegro5 glfw_opengl{2,3} glfw_vulkan null sdl_opengl{2,3} sdl_{sdlrenderer,vulkan} glut_opengl2 ; do
			${CXX} ${CXXFLAGS} ${CPPFLAGS} ${LDFLAGS} -fPIE examples/example_${f}/main.cpp "-L${S}" -limgui ${LIBS} -o "${S}/ex/example_${f}" || die
		done
	fi

	set +x || die
}

src_install() {
	dolib.so libimgui.so
	dodoc docs/*
	insinto "/usr/include/imgui"
	doins *.h
	doins -r misc/*/*.h
	doins backends/*.h
	insinto "/usr/share/${PN}/backends"
	doins -r backends/vulkan
	exeinto "/usr/libexec/${PN}"
	use freetype && doexe misc/fonts/binary_to_compressed_c
	rm -rf misc/{fonts,freetype} || die
	dodoc -r misc

	if use examples; then
		exeinto "/usr/libexec/${PN}/examples"
		doexe ex/*
		dodoc -r examples
		docompress -x "/usr/share/doc/${PF}/examples"
	fi
}
