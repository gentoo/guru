# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson toolchain-funcs

DESCRIPTION="A dynamic tiling Wayland compositor that doesn't sacrifice on its looks"
HOMEPAGE="https://github.com/hyprwm/Hyprland/releases"

CONTRIBCOMMIT=1af47a008e850c595aeddc83bb3f04fd81935caa
SRC_URI="https://github.com/hyprwm/${PN^}/releases/download/v${PV}/source-v${PV}.tar.gz -> ${PF}.gh.tar.gz
	https://github.com/hyprwm/contrib/archive/${CONTRIBCOMMIT}.tar.gz \
	-> contrib-${PV}.tar.gz
"
S="${WORKDIR}/${PN}-source"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"
IUSE="X grimblast legacy-renderer scratchpad shellevents systemd"

RDEPEND="
	app-misc/jq
	dev-libs/libevdev
	dev-libs/libinput
	dev-libs/wayland
	>=dev-libs/wayland-protocols-1.31
	dev-util/glslang
	dev-util/vulkan-headers
	gui-libs/gtk-layer-shell
	media-libs/libdisplay-info
	media-libs/libglvnd[X?]
	media-libs/mesa[gles2,wayland,X?]
	media-libs/vulkan-loader
	x11-base/xcb-proto
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pixman
	x11-misc/xkeyboard-config
	virtual/libudev
	grimblast? (
		 gui-apps/grim
		 gui-apps/slurp
		 gui-apps/wl-clipboard
		 x11-libs/libnotify
	)
	X? (
	   gui-libs/wlroots[x11-backend]
	   x11-base/xwayland
	   x11-libs/libxcb
	   x11-libs/xcb-util-image
	   x11-libs/xcb-util-renderutil
	   x11-libs/xcb-util-wm
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/hyprland-protocols
	dev-libs/libliftoff
	dev-vcs/git
	>=gui-libs/wlroots-0.16.0[X?]
	grimblast? ( app-text/scdoc )
	shellevents? ( app-text/scdoc )
"

src_prepare() {
	STDLIBVER=$(echo '#include <string>' | $(tc-getCXX) -x c++ -dM -E - | \
					grep GLIBCXX_RELEASE | sed 's/.*\([1-9][0-9]\)/\1/')
	if ! [[ ${STDLIBVER} -ge 12 ]]; then
		die "Hyprland requires >=sys-devel/gcc-12.1.0 to build"
	fi

	default
}

src_configure() {
	local emesonargs=(
		$(meson_feature legacy-renderer legacy_renderer)
		$(meson_feature X xwayland)
		$(meson_feature systemd)
	)

	meson_src_configure
}

src_install() {
	meson_src_install --skip-subprojects wlroots

	use grimblast && emake PREFIX="${ED}/usr" -C "${WORKDIR}/contrib-${CONTRIBCOMMIT}/grimblast" install
	use scratchpad && emake PREFIX="${ED}/usr" -C "${WORKDIR}/contrib-${CONTRIBCOMMIT}/scratchpad" install
	use shellevents && emake PREFIX="${ED}/usr" -C "${WORKDIR}/contrib-${CONTRIBCOMMIT}/shellevents" install
}
