# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-any-r1 meson

MY_PV=$(ver_cut 1-3)
[[ -n "$(ver_cut 4)" ]] && MY_PV_REV="-$(ver_cut 4)"

IMGUI_VER="1.81"
IMGUI_MESON_WRAP_VER="1"

DESCRIPTION="Vulkan and OpenGL overlay for monitoring FPS, sensors, system load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"

SRC_URI="
	https://github.com/flightlessmango/MangoHud/archive/v${MY_PV}${MY_PV_REV}.tar.gz -> ${P}.tar.gz
	https://github.com/ocornut/imgui/archive/v${IMGUI_VER}.tar.gz -> imgui-${IMGUI_VER}.tar.gz
	https://wrapdb.mesonbuild.com/v2/imgui_${IMGUI_VER}-${IMGUI_MESON_WRAP_VER}/get_patch -> imgui-${IMGUI_VER}-${IMGUI_MESON_WRAP_VER}-meson-wrap.zip
"

KEYWORDS="~amd64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE="+dbus debug +X xnvctrl wayland video_cards_nvidia"

REQUIRED_USE="
	|| ( X wayland )
	xnvctrl? ( video_cards_nvidia )"

BDEPEND="
	app-arch/unzip
	$(python_gen_any_dep 'dev-python/mako[${PYTHON_USEDEP}]')
"

python_check_deps() {
	python_has_version "dev-python/mako[${PYTHON_USEDEP}]"
}

DEPEND="
	dev-libs/spdlog
	dev-util/glslang
	>=dev-util/vulkan-headers-1.2
	media-libs/vulkan-loader
	media-libs/libglvnd
	x11-libs/libdrm
	dbus? ( sys-apps/dbus )
	X? ( x11-libs/libX11 )
	video_cards_nvidia? (
		x11-drivers/nvidia-drivers
		xnvctrl? ( x11-drivers/nvidia-drivers[static-libs] )
	)
	wayland? ( dev-libs/wayland )
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/MangoHud-${PV}"

# We do not enable this patch for now until imgui ebuild supports multilib

# PATCHES=(
# 	"${FILESDIR}/mangohud-0.6.6-meson-fix-imgui-dep.patch"
# )

src_unpack() {
	default
	[[ -n "${MY_PV_REV}" ]] && ( mv "${WORKDIR}/MangoHud-${MY_PV}${MY_PV_REV}" "${WORKDIR}/MangoHud-${PV}" || die )

	unpack imgui-${IMGUI_VER}.tar.gz
	unpack imgui-${IMGUI_VER}-${IMGUI_MESON_WRAP_VER}-meson-wrap.zip
	mv "${WORKDIR}/imgui-${IMGUI_VER}" "${S}/subprojects/imgui" || die
}

src_configure() {
	local emesonargs=(
		-Dappend_libdir_mangohud=false
		-Duse_system_spdlog=enabled
		-Duse_system_vulkan=enabled
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
