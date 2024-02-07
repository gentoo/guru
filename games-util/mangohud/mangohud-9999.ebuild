# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit python-single-r1 meson-multilib

MY_PV=$(ver_cut 1-3)
[[ -n "$(ver_cut 4)" ]] && MY_PV_REV="-$(ver_cut 4)"

DESCRIPTION="Vulkan and OpenGL overlay for monitoring FPS, sensors, system load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"

VK_HEADERS_VER="1.2.158"
VK_HEADERS_MESON_WRAP_VER="2"

IMPLOT_VER="0.16"
IMPLOT_MESON_WRAP_VER="1"
SPDLOG_VER="1.13.0"

SRC_URI="
	https://github.com/KhronosGroup/Vulkan-Headers/archive/v${VK_HEADERS_VER}.tar.gz
		-> vulkan-headers-${VK_HEADERS_VER}.tar.gz
	https://wrapdb.mesonbuild.com/v2/vulkan-headers_${VK_HEADERS_VER}-${VK_HEADERS_MESON_WRAP_VER}/get_patch
		-> vulkan-headers-${VK_HEADERS_VER}-${VK_HEADERS_MESON_WRAP_VER}-meson-wrap.zip
	https://github.com/epezent/implot/archive/refs/tags/v${IMPLOT_VER}.tar.gz
		-> implot-${IMPLOT_VER}.tar.gz
	https://wrapdb.mesonbuild.com/v2/implot_${IMPLOT_VER}-${IMPLOT_MESON_WRAP_VER}/get_patch
		-> implot-${IMPLOT_VER}-${IMPLOT_MESON_WRAP_VER}-meson-wrap.zip
	https://github.com/gabime/spdlog/archive/refs/tags/v${SPDLOG_VER}.tar.gz -> spdlog-${SPDLOG_VER}.tar.gz
	https://wrapdb.mesonbuild.com/v2/spdlog_${SPDLOG_VER}-1/get_patch -> spdlog-${SPDLOG_VER}-1-wrap.zip
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
IUSE="+dbus debug +X xnvctrl wayland video_cards_nvidia video_cards_amdgpu"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	|| ( X wayland )
	xnvctrl? ( video_cards_nvidia )
"

BDEPEND="
	app-arch/unzip
	$(python_gen_cond_dep 'dev-python/mako[${PYTHON_USEDEP}]')
"

RDEPEND="
	${PYTHON_DEPS}
	~media-libs/imgui-1.81[opengl,vulkan,${MULTILIB_USEDEP}]
	dev-cpp/nlohmann_json
	dev-util/glslang
	media-fonts/lato
	media-libs/vulkan-loader[${MULTILIB_USEDEP}]
	media-libs/libglvnd[${MULTILIB_USEDEP}]
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	dbus? ( sys-apps/dbus[${MULTILIB_USEDEP}] )
	X? ( x11-libs/libX11[${MULTILIB_USEDEP}] )
	video_cards_nvidia? (
		x11-drivers/nvidia-drivers[${MULTILIB_USEDEP}]
		xnvctrl? ( x11-drivers/nvidia-drivers[static-libs] )
	)
	wayland? ( dev-libs/wayland[${MULTILIB_USEDEP}] )
	$(python_gen_cond_dep '
		|| (
			dev-python/matplotlib[gtk3,${PYTHON_USEDEP}]
			dev-python/matplotlib[qt5,${PYTHON_USEDEP}]
			dev-python/matplotlib[wxwidgets,${PYTHON_USEDEP}]
		)
	')
"

PATCHES=(
	"${FILESDIR}/mangohud-v0.7.0-meson-fix-imgui-dep.patch"
)

src_unpack() {

	default

	[[ -n "${MY_PV_REV}" ]] && ( mv "${WORKDIR}/MangoHud-${MY_PV}${MY_PV_REV}" "${WORKDIR}/MangoHud-${PV}" || die )

	if [[ $PV == 9999 ]]; then
		git-r3_src_unpack
	fi

	unpack vulkan-headers-${VK_HEADERS_VER}.tar.gz
	unpack vulkan-headers-${VK_HEADERS_VER}-${VK_HEADERS_MESON_WRAP_VER}-meson-wrap.zip
	mv "${WORKDIR}/Vulkan-Headers-${VK_HEADERS_VER}" "${S}/subprojects/" || die

	unpack implot-${IMPLOT_VER}.tar.gz
	unpack implot-${IMPLOT_VER}-${IMPLOT_MESON_WRAP_VER}-meson-wrap.zip
	mv "${WORKDIR}/implot-${IMPLOT_VER}" "${S}/subprojects/" || die

	cd "${S}/subprojects/implot-${IMPLOT_VER}" || die
	eapply "${FILESDIR}/implot-v0.16-fix-imgui-dep.patch"

	# fix build error by using upstream submodule version of spdlog
	unpack spdlog-${SPDLOG_VER}.tar.gz
	unpack spdlog-${SPDLOG_VER}-1-wrap.zip
	mv "${WORKDIR}/spdlog-${SPDLOG_VER}" "${S}/subprojects/" || die
}

src_prepare() {
	default
	# replace all occurences of "#include <imgui.h>" to "#include <imgui/imgui.h>"
	find . -type f -exec sed -i 's|<imgui.h>|<imgui/imgui.h>|g' {} \; || die
	find . -type f -exec sed -i 's|"imgui.h"|<imgui/imgui.h>|g' {} \; || die
	find . -type f -exec sed -i 's|<imgui_internal.h>|<imgui/imgui_internal.h>|g' {} \; || die
	find . -type f -exec sed -i 's|"imgui_internal.h"|<imgui/imgui_internal.h>|g' {} \; || die
}

multilib_src_configure() {
	# disable system spdlog in favor of the submodule version
	local emesonargs=(
		-Dappend_libdir_mangohud=false
		-Duse_system_spdlog=disabled
		-Dinclude_doc=false
		$(meson_feature video_cards_nvidia with_nvml)
		$(meson_feature xnvctrl with_xnvctrl)
		$(meson_feature X with_x11)
		$(meson_feature wayland with_wayland)
		$(meson_feature dbus with_dbus)
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
