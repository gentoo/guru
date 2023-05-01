# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )

inherit python-any-r1 meson

MY_PV=$(ver_cut 1-3)
[[ -n "$(ver_cut 4)" ]] && MY_PV_REV="-$(ver_cut 4)"

DESCRIPTION="Vulkan and OpenGL overlay for monitoring FPS, sensors, system load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/flightlessmango/MangoHud.git"
else
	SRC_URI="https://github.com/flightlessmango/MangoHud/archive/v${MY_PV}${MY_PV_REV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

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
	~media-libs/imgui-1.81[opengl,vulkan]
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

[[ "$PV" != "9999" ]] && S="${WORKDIR}/MangoHud-${PV}"

PATCHES=(
	"${FILESDIR}/mangohud-0.6.6-meson-fix-imgui-dep.patch"
)

src_unpack() {
	default
	[[ $PV == 9999 ]] && git-r3_src_unpack
	[[ $PV != 9999 && -n "${MY_PV_REV}" ]] && ( mv "${WORKDIR}/MangoHud-${MY_PV}${MY_PV_REV}" "${WORKDIR}/MangoHud-${PV}" || die )
}

src_prepare() {
	default
	# replace all occurences of "#include <imgui.h>" to "#include <imgui/imgui.h>"
	find . -type f -exec sed -i 's/#include <imgui.h>/#include <imgui\/imgui.h>/g' {} \;
	find . -type f -exec sed -i 's/#include "imgui.h"/#include <imgui\/imgui.h>/g' {} \;
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
