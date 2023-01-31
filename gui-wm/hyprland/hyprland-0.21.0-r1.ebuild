# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson toolchain-funcs

DESCRIPTION="A dynamic tiling Wayland compositor that doesn't sacrifice on its looks"
HOMEPAGE="https://github.com/hyprwm/Hyprland/releases"

PROTOCOMMIT=301733ae466b229066ba15a53e6d8b91c5dcef5b
WLRCOMMIT=dc7cc98cf21a8dc19ab8895505500e3700646af0
CONTRIBCOMMIT=37c8121f98d76f57caa00dd7106877876e0d7483
SRC_URI="https://github.com/hyprwm/${PN^}/archive/v${PV}beta.tar.gz -> ${PF}.tar.gz
	https://github.com/hyprwm/hyprland-protocols/archive/${PROTOCOMMIT}.tar.gz -> hyprland-protocols.tar.gz
	https://github.com/hyprwm/contrib/archive/${CONTRIBCOMMIT}.tar.gz -> contrib.tar.gz
	https://gitlab.freedesktop.org/wlroots/wlroots/-/archive/${WLRCOMMIT}/wlroots-${WLRCOMMIT}.tar.bz2 -> wlr.tar.bz2"
S="${WORKDIR}/${PN^}-${PV}beta"

KEYWORDS="~amd64"
LICENSE="BSD"
SLOT="0"
IUSE="X grimblast shellevents systemd"

RDEPEND="
	app-misc/jq
	dev-libs/libevdev
	dev-libs/libinput
	dev-libs/wayland
	>=dev-libs/wayland-protocols-1.31
	dev-util/glslang
	dev-util/vulkan-headers
	gui-libs/gtk-layer-shell
	gui-libs/wlroots[X?]
	media-libs/libglvnd[X?]
	media-libs/mesa[gles2,wayland,X?]
	media-libs/vulkan-loader
	x11-base/xcb-proto
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pixman
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

PATCHES=(
	"${FILESDIR}/0.21.0-meson.patch"
)

src_unpack() {
	default

	rmdir "${S}/subprojects/wlroots"
	rmdir "${S}/subprojects/hyprland-protocols"
	mv "${WORKDIR}/wlroots-${WLRCOMMIT}" "${S}/subprojects/wlroots" || die
	mv "${WORKDIR}/hyprland-protocols-${PROTOCOMMIT}" "${S}/subprojects/hyprland-protocols" || die
	# Workaround for https://github.com/hyprwm/Hyprland/issues/1207
	cp "${S}/subprojects/hyprland-protocols/protocols/hyprland-toplevel-export-v1.xml" "${S}/protocols" || die
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
		$(meson_feature X xwayland)
		$(meson_feature systemd)
	)

	meson_src_configure
}

src_install() {
	meson_src_install --skip-subprojects

	use grimblast && emake PREFIX="${ED}/usr" -C "${WORKDIR}/contrib-${CONTRIBCOMMIT}/grimblast" install
	use shellevents && emake PREFIX="${ED}/usr" -C "${WORKDIR}/contrib-${CONTRIBCOMMIT}/shellevents" install
}
