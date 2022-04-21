# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic toolchain-funcs

CMAKE_IN_SOURCE_BUILD=1

DESCRIPTION="Bloat-free graphical user interface library for C++"
HOMEPAGE="
	https://github.com/ocornut/imgui
	https://github.com/cimgui/cimgui
"
SRC_URI="
	https://github.com/ocornut/imgui/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/cimgui/cimgui/archive/refs/tags/${PV}.tar.gz -> c${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="allegro bindings examples freetype glfw glut opengl sdl vulkan"
S="${WORKDIR}/c${P}"

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
BDEPEND="
	bindings? ( dev-lang/luajit )
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/c${P}-fix-cmake.patch" )
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
	pushd ../ || die
	rm -rf "${S}/imgui" || die
	mv "${P}" "${S}/imgui" || die
	pushd "${S}/imgui" || die

	# imgui
	rm -r examples/libs || die
	rm -r misc/*/*.ttf || die
	rm -r misc/single_file || die

	# cimgui
	if use bindings; then
		pushd "${S}" || die
		cmake_src_prepare
	else
		eapply_user
	fi
}

src_configure() {
	pushd imgui || die

	# imgui
	tc-export CXX
	append-cppflags "-DIMGUI_USE_WCHAR32"
	COMMONFLAGS="-I${S}/imgui -I${S}/imgui/backends -I${S}/imgui/misc/freetype -fPIC -fpermissive"
	local PKGCONF="$(tc-getPKG_CONFIG)" || die

	use allegro && append-libs "-lallegro -lallegro_main -lallegro_primitives"
	if use freetype; then
		append-cppflags "-DIMGUI_ENABLE_FREETYPE -DIMGUI_ENABLE_STB_TRUETYPE"
		COMMONFLAGS="${COMMONFLAGS} $(${PKGCONF} --cflags freetype2)" || die
		append-libs "$(${PKGCONF} --libs freetype2)" || die
	fi
	if use glfw; then
		append-libs "$(${PKGCONF} --libs glfw3)" || die
		COMMONFLAGS="${COMMONFLAGS} $(${PKGCONF} --cflags glfw3)" || die
	fi
	if use glut; then
		append-libs "$(${PKGCONF} --libs freeglut)" || die
		COMMONFLAGS="${COMMONFLAGS} $(${PKGCONF} --cflags freeglut)" || die
	fi
	use opengl && append-libs "-lGL"
	if use sdl; then
		append-libs "-ldl $(sdl2-config --libs)" || die
		COMMONFLAGS="${COMMONFLAGS} $(sdl2-config --cflags)" || die
	fi
	if use vulkan; then
		append-libs "$(${PKGCONF} --libs vulkan)" || die
		COMMONFLAGS="${COMMONFLAGS} $(${PKGCONF} --cflags vulkan)" || die
		append-cppflags "-DImTextureID=ImU64" || die
	fi
	append-cxxflags "${COMMONFLAGS}"
	popd || die

	# cimgui
	if use bindings; then
		local mycmakeargs=(
			-DIMGUI_FREETYPE=$(usex freetype)
			-DIMGUI_STATIC=OFF
		)
		cmake_src_configure
	fi
}

src_compile() {
	pushd imgui || die

	# imgui
	set -x || die

	local objects=()

	for i in imgui{,_draw,_demo,_tables,_widgets}; do
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -fPIC -c ${i}.cpp -o ${i}.o || die
		objects+=( ${i}.o )
	done

	if use freetype; then
		pushd misc/freetype || die
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -fPIC -c imgui_freetype.cpp -o imgui_freetype.o || die
		objects+=( misc/freetype/imgui_freetype.o )
		popd || die
		pushd misc/fonts || die
		${CXX} ${CXXFLAGS} ${CPPFLAGS} ${LDFLAGS} -fPIE binary_to_compressed_c.cpp -o binary_to_compressed_c || die
		popd || die
	fi

	pushd backends || die
	if use allegro; then
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -fPIC -c imgui_impl_allegro5.cpp -o imgui_impl_allegro5.o || die
		objects+=( backends/imgui_impl_allegro5.o )
	fi
	if use glfw; then
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -fPIC -c imgui_impl_glfw.cpp -o imgui_impl_glfw.o || die
		objects+=( backends/imgui_impl_glfw.o )
	fi
	if use glut; then
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -fPIC -c imgui_impl_glut.cpp -o imgui_impl_glut.o || die
		objects+=( backends/imgui_impl_glut.o )
	fi
	if use opengl; then
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -fPIC -c imgui_impl_opengl2.cpp -o imgui_impl_opengl2.o || die
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -fPIC -c imgui_impl_opengl3.cpp -o imgui_impl_opengl3.o || die
		objects+=( backends/imgui_impl_opengl2.o backends/imgui_impl_opengl3.o )
	fi
	if use sdl; then
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -fPIC -c imgui_impl_sdl.cpp -o imgui_impl_sdl.o || die
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -fPIC -c imgui_impl_sdlrenderer.cpp -o imgui_impl_sdlrenderer.o || die
		objects+=( backends/imgui_impl_sdl.o backends/imgui_impl_sdlrenderer.o )
	fi
	if use vulkan; then
		${CXX} ${CXXFLAGS} ${CPPFLAGS} -fPIC -c imgui_impl_vulkan.cpp -o imgui_impl_vulkan.o || die
		objects+=( backends/imgui_impl_vulkan.o )
	fi
	popd || die
	${CXX} ${CXXFLAGS} ${CPPFLAGS} ${LDFLAGS} -shared -Wl,-soname,libimgui.so ${objects[@]} -o libimgui.so ${LIBS} || die

	if use examples; then
		mkdir ex || die
		for f in allegro5 glfw_opengl{2,3} glfw_vulkan null sdl_opengl{2,3} sdl_{sdlrenderer,vulkan} glut_opengl2 ; do
			${CXX} ${CXXFLAGS} ${CPPFLAGS} ${LDFLAGS} -fPIE examples/example_${f}/main.cpp "-L${S}/imgui" -limgui ${LIBS} -o "${S}/imgui/ex/example_${f}" || die
		done
	fi

	set +x || die
	popd || die

	# cimgui
	if use bindings; then
		pushd generator || die
		local myargs=()
		use allegro && myargs+=( allegro5 )
		use glfw && myargs+=( glfw )
		use glut && myargs+=( glut )
		use opengl && myargs+=( opengl3 opengl2 )
		use sdl && myargs+=( sdl sdlrenderer )
		use vulkan && myargs+=( vulkan )
		myargs+=( ${CFLAGS} ${COMMONFLAGS} ${CPPFLAGS} )

		if use freetype ; then
			luajit ./generator.lua gcc "internal freetype" ${myargs[@]} || die
		else
			luajit ./generator.lua gcc "internal" ${myargs[@]} || die
		fi
		popd || die
		cmake_src_compile
	fi
}

src_install() {
	pushd imgui || die

	# imgui
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

	popd || die

	# cimgui
	if use bindings; then
		dolib.so libcimgui.so
		insinto "/usr/share/doc/${PF}/cimgui"
		doins README.md TODO.txt
		doheader cimgui.h
	fi
}
