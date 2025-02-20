# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit flag-o-matic python-single-r1 meson-multilib

MY_PV=$(ver_cut 1-3)
[[ -n "$(ver_cut 4)" ]] && MY_PV_REV="-$(ver_cut 4)"

DESCRIPTION="Vulkan and OpenGL overlay for monitoring FPS, sensors, system load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"

VK_HEADERS_VER="1.2.158"
VK_HEADERS_MESON_WRAP_VER="2"

SRC_URI="
	https://github.com/KhronosGroup/Vulkan-Headers/archive/v${VK_HEADERS_VER}.tar.gz
		-> vulkan-headers-${VK_HEADERS_VER}.tar.gz
	https://wrapdb.mesonbuild.com/v2/vulkan-headers_${VK_HEADERS_VER}-${VK_HEADERS_MESON_WRAP_VER}/get_patch
		-> vulkan-headers-${VK_HEADERS_VER}-${VK_HEADERS_MESON_WRAP_VER}-meson-wrap.zip
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/flightlessmango/MangoHud.git"
else
	SRC_URI+="
		https://github.com/flightlessmango/MangoHud/archive/v${MY_PV}${MY_PV_REV}.tar.gz
			-> ${P}.tar.gz
	"
	KEYWORDS="~amd64"
	S="${WORKDIR}/MangoHud-${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+dbus debug +X xnvctrl wayland mangoapp mangohudctl mangoplot video_cards_nvidia video_cards_amdgpu test"
RESTRICT="!test? ( test )"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	|| ( X wayland )
	xnvctrl? ( video_cards_nvidia )
	mangoapp? ( X )
"

BDEPEND="
	app-arch/unzip
	dev-util/glslang
	test? ( dev-util/cmocka )
	$(python_gen_cond_dep 'dev-python/mako[${PYTHON_USEDEP}]')
"

DEPEND="
	${PYTHON_DEPS}
	=media-libs/imgui-1.89.9*:=[opengl,vulkan,${MULTILIB_USEDEP}]
	=media-libs/implot-0.16*:=[${MULTILIB_USEDEP}]
	dev-libs/spdlog:=[${MULTILIB_USEDEP}]
	dev-libs/libfmt:=[${MULTILIB_USEDEP}]
	dev-cpp/nlohmann_json
	x11-libs/libxkbcommon
	dbus? ( sys-apps/dbus[${MULTILIB_USEDEP}] )
	X? ( x11-libs/libX11[${MULTILIB_USEDEP}] )
	video_cards_nvidia? (
		x11-drivers/nvidia-drivers[${MULTILIB_USEDEP}]
		xnvctrl? ( x11-drivers/nvidia-drivers[static-libs] )
	)
	wayland? ( dev-libs/wayland[${MULTILIB_USEDEP}] )
	mangoapp? (
		=media-libs/imgui-1.89.9*[glfw]
		media-libs/glfw[X(+)?,wayland(+)?]
		media-libs/glew
	)
"

RDEPEND="
	${DEPEND}
	media-libs/libglvnd[${MULTILIB_USEDEP}]
	media-libs/vulkan-loader[${MULTILIB_USEDEP}]
	mangoplot? (
		media-fonts/lato
		$(python_gen_cond_dep '
			|| (
				dev-python/matplotlib[gtk3,${PYTHON_USEDEP}]
				dev-python/matplotlib[qt5(-),${PYTHON_USEDEP}]
				dev-python/matplotlib[qt6(-),${PYTHON_USEDEP}]
				dev-python/matplotlib[wxwidgets,${PYTHON_USEDEP}]
			)
		')
	)
"

src_unpack() {
	default

	[[ -n "${MY_PV_REV}" ]] && ( mv "${WORKDIR}/MangoHud-${MY_PV}${MY_PV_REV}" "${WORKDIR}/MangoHud-${PV}" || die )

	if [[ $PV == 9999 ]]; then
		git-r3_src_unpack
	fi

	unpack vulkan-headers-${VK_HEADERS_VER}.tar.gz
	unpack vulkan-headers-${VK_HEADERS_VER}-${VK_HEADERS_MESON_WRAP_VER}-meson-wrap.zip
	mv "${WORKDIR}/Vulkan-Headers-${VK_HEADERS_VER}" "${S}/subprojects/" || die
}

src_prepare() {
	default
	# replace all occurences of "#include <imgui.h>" to "#include <imgui/imgui.h>"
	find . -type f -exec sed -i 's|<imgui.h>|<imgui/imgui.h>|g' {} \; || die
	find . -type f -exec sed -i 's|"imgui.h"|<imgui/imgui.h>|g' {} \; || die
	find . -type f -exec sed -i 's|<imgui_internal.h>|<imgui/imgui_internal.h>|g' {} \; || die
	find . -type f -exec sed -i 's|"imgui_internal.h"|<imgui/imgui_internal.h>|g' {} \; || die
	find . -type f -exec sed -i 's|"imgui_impl_glfw.h"|<imgui/imgui_impl_glfw.h>|g' {} \; || die
	find . -type f -exec sed -i 's|"imgui_impl_opengl3.h"|<imgui/imgui_impl_opengl3.h>|g' {} \; || die
}

multilib_src_configure() {
	# workaround for lld
	# https://github.com/flightlessmango/MangoHud/issues/1240
	append-ldflags $(test-flags-CCLD -Wl,--undefined-version)

	local emesonargs=(
		-Dappend_libdir_mangohud=false
		-Dinclude_doc=false
		-Duse_system_spdlog=enabled
		$(meson_feature video_cards_nvidia with_nvml)
		$(meson_feature xnvctrl with_xnvctrl)
		$(meson_feature X with_x11)
		$(meson_feature wayland with_wayland)
		$(meson_feature dbus with_dbus)
		$(meson_use mangoapp mangoapp)
		$(meson_use mangoapp mangoapp_layer)
		$(meson_use mangohudctl mangohudctl)
		$(meson_feature mangoplot mangoplot)
	)
	meson_src_configure
}

pkg_postinst() {
	if ! use xnvctrl; then
		einfo ""
		einfo "If mangohud can't get GPU load, or other GPU information,"
		einfo "and you have an older Nvidia device."
		einfo ""
		einfo "Try enabling the 'xnvctrl' useflag."
		einfo ""
	fi
}
