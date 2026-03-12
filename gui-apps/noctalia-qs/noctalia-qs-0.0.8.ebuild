# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit branding cmake

GIT_REVISION=d5209a6b5fe8c6dff8d530e820c96f09830011e3

DESCRIPTION="Toolkit for building desktop widgets using QtQuick"
HOMEPAGE="https://quickshell.org/"

if [[ "${PV}" = *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/noctalia-dev/noctalia-qs.git"
else
	SRC_URI="https://github.com/noctalia-dev/noctalia-qs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="LGPL-3"
SLOT="0"

# Upstream recommends leaving all build options enabled by default
IUSE="
	+jemalloc +sockets
	+wayland +layer-shell +session-lock +toplevel-management
	+hyprland +screencopy
	+X +i3
	+tray +pipewire +mpris +pam +polkit +greetd +upower +notifications
	+bluetooth +network
	lto
"
REQUIRED_USE="
	layer-shell?         ( wayland )
	session-lock?        ( wayland )
	toplevel-management? ( wayland )
	hyprland?            ( wayland )
	screencopy?          ( wayland )
"

RDEPEND="
	!gui-apps/quickshell
	dev-qt/qtbase:6=[dbus,vulkan]
	dev-qt/qtsvg:6=
	dev-qt/qtdeclarative:6=
	jemalloc? ( dev-libs/jemalloc )
	wayland? (
		dev-libs/wayland
		dev-qt/qtwayland:6=
	)
	screencopy? (
		x11-libs/libdrm
		media-libs/mesa
	)
	X? ( x11-libs/libxcb )
	pipewire? ( media-video/pipewire )
	pam? ( sys-libs/pam )
	polkit? (
		sys-auth/polkit
		dev-libs/glib
	)
	bluetooth? ( net-wireless/bluez )
	network? ( net-misc/networkmanager )
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-cpp/cli11
	dev-util/spirv-tools
	dev-qt/qtshadertools:6
	screencopy? ( dev-util/vulkan-headers )
	wayland? (
		dev-util/wayland-scanner
		dev-libs/wayland-protocols
	)
"

DOCS=( README.md changelog/ )

src_configure() {
	# hyprland controls all Hyprland sub-features as a group.
	# i3 controls I3/Sway IPC.
	# screencopy controls all screencopy backends (icc, wlr, hyprland-toplevel).
	local _hyprland=$(usex hyprland ON OFF)
	local _screencopy=$(usex screencopy ON OFF)
	local _i3=$(usex i3 ON OFF)

	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DDISTRIBUTOR="${BRANDING_OS_NAME} GURU"
		-DINSTALL_QML_PREFIX="$(get_libdir)/qt6/qml"
		-DGIT_REVISION=${GIT_REVISION}
		-DCRASH_HANDLER=OFF # dev-cpp/cpptrace::gentoo does not have required use flags
		-DUSE_JEMALLOC=$(usex jemalloc ON OFF)
		-DSOCKETS=$(usex sockets ON OFF)
		-DWAYLAND=$(usex wayland ON OFF)
		-DWAYLAND_WLR_LAYERSHELL=$(usex layer-shell ON OFF)
		-DWAYLAND_SESSION_LOCK=$(usex session-lock ON OFF)
		-DWAYLAND_TOPLEVEL_MANAGEMENT=$(usex toplevel-management ON OFF)
		-DHYPRLAND=${_hyprland}
		-DHYPRLAND_IPC=${_hyprland}
		-DHYPRLAND_GLOBAL_SHORTCUTS=${_hyprland}
		-DHYPRLAND_FOCUS_GRAB=${_hyprland}
		-DHYPRLAND_SURFACE_EXTENSIONS=${_hyprland}
		-DSCREENCOPY=${_screencopy}
		-DSCREENCOPY_ICC=${_screencopy}
		-DSCREENCOPY_WLR=${_screencopy}
		-DSCREENCOPY_HYPRLAND_TOPLEVEL=${_screencopy}
		-DX11=$(usex X ON OFF)
		-DI3=${_i3}
		-DI3_IPC=${_i3}
		-DSERVICE_STATUS_NOTIFIER=$(usex tray ON OFF)
		-DSERVICE_PIPEWIRE=$(usex pipewire ON OFF)
		-DSERVICE_MPRIS=$(usex mpris ON OFF)
		-DSERVICE_PAM=$(usex pam ON OFF)
		-DSERVICE_POLKIT=$(usex polkit ON OFF)
		-DSERVICE_GREETD=$(usex greetd ON OFF)
		-DSERVICE_UPOWER=$(usex upower ON OFF)
		-DSERVICE_NOTIFICATIONS=$(usex notifications ON OFF)
		-DBLUETOOTH=$(usex bluetooth ON OFF)
		-DNETWORK=$(usex network ON OFF)
		-DLTO=$(usex lto ON OFF)
	)
	cmake_src_configure
}
