# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson toolchain-funcs

DESCRIPTION="A dynamic tiling Wayland compositor that doesn't sacrifice on its looks"
HOMEPAGE="https://github.com/hyprwm/Hyprland/releases"

PROTOCOMMIT=4d29e48433270a2af06b8bc711ca1fe5109746cd
WLRCOMMIT=7abda952d0000b72d240fe1d41457b9288f0b6e5
CONTRIBCOMMIT=1af47a008e850c595aeddc83bb3f04fd81935caa
UDISCOMMIT=5336633af70f3917760a6d441ff02d93477b0c86
SRC_URI="https://github.com/hyprwm/${PN^}/archive/v${PV}.tar.gz -> ${PF}.tar.gz
	https://github.com/hyprwm/hyprland-protocols/archive/${PROTOCOMMIT}.tar.gz \
	-> hyprland-protocols-${PV}.tar.gz
	https://github.com/hyprwm/contrib/archive/${CONTRIBCOMMIT}.tar.gz \
	-> contrib-${PV}.tar.gz
	https://github.com/canihavesomecoffee/udis86/archive/${UDISCOMMIT}.tar.gz \
	-> udis-${PV}.tar.gz
	https://gitlab.freedesktop.org/wlroots/wlroots/-/archive/${WLRCOMMIT}/wlroots-${WLRCOMMIT}.tar.bz2 \
	-> wlr-${PV}.tar.bz2"
S="${WORKDIR}/${PN^}-${PV}"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"
IUSE="X grimblast legacy-renderer scratchpad shellevents systemd"

RDEPEND="
	app-misc/jq
	dev-libs/libevdev
	dev-libs/libinput
	dev-libs/libliftoff
	dev-libs/wayland
	>=dev-libs/wayland-protocols-1.31
	dev-util/glslang
	dev-util/vulkan-headers
	gui-libs/gtk-layer-shell
	gui-libs/wlroots[X?]
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
	grimblast? ( app-text/scdoc )
	shellevents? ( app-text/scdoc )
"

src_unpack() {
	default

	rmdir "${S}/subprojects/wlroots"
	rmdir "${S}/subprojects/hyprland-protocols"
	rmdir "${S}/subprojects/udis86"
	mv "${WORKDIR}/wlroots-${WLRCOMMIT}" "${S}/subprojects/wlroots" || die
	mv "${WORKDIR}/hyprland-protocols-${PROTOCOMMIT}" "${S}/subprojects/hyprland-protocols" || die
	mv "${WORKDIR}/udis86-${UDISCOMMIT}" "${S}/subprojects/udis86" || die
	# Workaround for https://github.com/hyprwm/Hyprland/issues/1207
	cp "${S}/subprojects/hyprland-protocols/protocols/hyprland-toplevel-export-v1.xml" "${S}/protocols" || die
	cp "${S}/subprojects/hyprland-protocols/protocols/hyprland-global-shortcuts-v1.xml" "${S}/protocols" || die
}

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
	meson_src_install --skip-subprojects

	use grimblast && emake PREFIX="${ED}/usr" -C "${WORKDIR}/contrib-${CONTRIBCOMMIT}/grimblast" install
	use scratchpad && emake PREFIX="${ED}/usr" -C "${WORKDIR}/contrib-${CONTRIBCOMMIT}/scratchpad" install
	use shellevents && emake PREFIX="${ED}/usr" -C "${WORKDIR}/contrib-${CONTRIBCOMMIT}/shellevents" install
}
