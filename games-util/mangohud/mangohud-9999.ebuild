# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit flag-o-matic python-single-r1 meson-multilib toolchain-funcs

DESCRIPTION="Vulkan and OpenGL overlay for monitoring FPS, sensors, system load and more"
HOMEPAGE="https://github.com/flightlessmango/MangoHud"

# Check subprojects/vk-bootstrap.wrap for this value
VK_BOOTSTRAP_VER="1.4.328"
# Check subprojects/vulkan-headers.wrap for this value
VK_HEADERS_VER="1.4.346"
# Check subprojects/vkroots.wrap for this value
VKROOTS_COMMIT="5106d8a0df95de66cc58dc1ea37e69c99afc9540"

SRC_URI="
	https://github.com/KhronosGroup/Vulkan-Headers/archive/v${VK_HEADERS_VER}.tar.gz
		-> Vulkan-Headers-${VK_HEADERS_VER}.tar.gz
	https://github.com/KhronosGroup/Vulkan-Utility-Libraries/archive/v${VK_HEADERS_VER}.tar.gz
		-> Vulkan-Utility-Libraries-${VK_HEADERS_VER}.tar.gz
	https://github.com/charles-lunarg/vk-bootstrap/archive/refs/tags/v${VK_BOOTSTRAP_VER}.tar.gz
		-> vk-bootstrap-${VK_BOOTSTRAP_VER}.tar.gz
	https://github.com/misyltoad/vkroots/archive/${VKROOTS_COMMIT}.tar.gz
		-> vkroots-${VKROOTS_COMMIT}.tar.gz
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/flightlessmango/MangoHud.git"
else
	SRC_URI+="https://github.com/flightlessmango/MangoHud/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/MangoHud-${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+dbus elogind mangoapp mangohudctl mangoplot next systemd test video_cards_nvidia wayland +X xnvctrl"
RESTRICT="test" # tests aren't enabled upstream

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	|| ( X wayland )
	xnvctrl? ( video_cards_nvidia X )
	mangoapp? ( X )
"

BDEPEND="
	dev-util/glslang
	test? ( dev-util/cmocka )
	$(python_gen_cond_dep 'dev-python/mako[${PYTHON_USEDEP}]')
"

DEPEND="
	${PYTHON_DEPS}
	next? (
		dev-cpp/yaml-cpp:=[${MULTILIB_USEDEP}]
		=media-libs/imgui-1.91.6*:=[opengl,vulkan,${MULTILIB_USEDEP}]
		media-libs/mesa[opengl,${MULTILIB_USEDEP}]
		elogind? ( sys-auth/elogind )
		systemd? ( sys-apps/systemd[${MULTILIB_USEDEP}] )
	)
	dev-libs/spdlog:=[${MULTILIB_USEDEP}]
	dev-libs/libfmt:=[${MULTILIB_USEDEP}]
	=media-libs/imgui-1.91.6*:=[${MULTILIB_USEDEP}]
	=media-libs/implot-0.16*:=[${MULTILIB_USEDEP}]
	sys-libs/libcap[${MULTILIB_USEDEP}]
	x11-libs/libdrm[${MULTILIB_USEDEP}]
	x11-libs/libxkbcommon:=[${MULTILIB_USEDEP}]
	dbus? ( sys-apps/dbus[${MULTILIB_USEDEP}] )
	X? ( x11-libs/libX11[${MULTILIB_USEDEP}] )
	video_cards_nvidia? (
		x11-drivers/nvidia-drivers[${MULTILIB_USEDEP}]
		xnvctrl? ( x11-drivers/nvidia-drivers[static-libs] )
	)
	wayland? (
		dev-libs/wayland[${MULTILIB_USEDEP}]
		dev-libs/wayland-protocols
	)
	mangoapp? (
		=media-libs/imgui-1.91.6*[glfw,opengl]
		media-libs/glfw[X(+)?,wayland(+)?]
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

PATCHES=(
	"${FILESDIR}/${PN}-9999-system-libs.patch"
)

src_unpack() {
	default

	if [[ $PV == 9999 ]]; then
		git-r3_src_unpack
	fi

	unpack vkroots-${VKROOTS_COMMIT}.tar.gz
	unpack vk-bootstrap-${VK_BOOTSTRAP_VER}.tar.gz
	unpack Vulkan-Headers-${VK_HEADERS_VER}.tar.gz
	unpack Vulkan-Utility-Libraries-${VK_HEADERS_VER}.tar.gz
}

src_prepare() {
	default

	mv "${WORKDIR}/Vulkan-Headers-${VK_HEADERS_VER}" "${S}/subprojects/" || die
	mv "${WORKDIR}/Vulkan-Utility-Libraries-${VK_HEADERS_VER}" "${S}/subprojects/" || die
	mv "${WORKDIR}/vkroots-${VKROOTS_COMMIT}" "${S}/subprojects/vkroots" || die
	mv "${WORKDIR}/vk-bootstrap-${VK_BOOTSTRAP_VER}" "${S}/subprojects/vk-bootstrap" || die

	pushd subprojects || die
	mv packagefiles/vulkan-headers/* Vulkan-Headers-${VK_HEADERS_VER} || die
	mv packagefiles/vulkan-utility-libraries/* Vulkan-Utility-Libraries-${VK_HEADERS_VER} || die
	mv packagefiles/vkroots/* vkroots || die
	mv packagefiles/vk-bootstrap/* vk-bootstrap || die

	# save some space when using FEATURES=installsources
	rm -rf "*.wrap" "{packagefiles/imgui-0.16}" || die
	popd || die
}

multilib_src_configure() {
	# workaround for lld
	# https://github.com/flightlessmango/MangoHud/issues/1240
	if tc-ld-is-lld; then
		append-ldflags -Wl,--undefined-version
	fi

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
		$(meson_use next with_mangohud_next)
		$(meson_use mangohudctl mangohudctl)
		$(meson_feature mangoplot mangoplot)
		$(meson_feature test tests)
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
