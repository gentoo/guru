# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit branding cmake

GIT_REVISION=fb0cc1557d8321fb2e3f34e94beddefe56211e04

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
	+bluetooth +dwl +greetd +hyprland +i3 +jemalloc +layer-shell
	+mpris +networkmanager +niri +notifications +pam +pipewire +policykit
	+screencopy +session-lock +sockets +tray +toplevel-management
	+upower +wayland +X
"
REQUIRED_USE="
	hyprland?            ( wayland )
	layer-shell?         ( wayland )
	niri?                ( wayland )
	screencopy?          ( wayland )
	session-lock?        ( wayland )
	toplevel-management? ( wayland )
"

RDEPEND="
	!gui-apps/quickshell
	dev-qt/qtbase:6=[dbus,vulkan]
	dev-qt/qtdeclarative:6=
	dev-qt/qtsvg:6=
	bluetooth? ( net-wireless/bluez )
	jemalloc? ( dev-libs/jemalloc )
	networkmanager? ( net-misc/networkmanager )
	pam? ( sys-libs/pam )
	pipewire? ( media-video/pipewire )
	policykit? (
		dev-libs/glib
		sys-auth/polkit
	)
	screencopy? (
		media-libs/mesa
		x11-libs/libdrm
	)
	wayland? (
		dev-libs/wayland
		dev-qt/qtwayland:6=
	)
	X? ( x11-libs/libxcb )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-cpp/cli11
	dev-qt/qtshadertools:6
	dev-util/spirv-tools
	virtual/pkgconfig
	screencopy? ( dev-util/vulkan-headers )
	wayland? (
		dev-libs/wayland-protocols
		dev-util/wayland-scanner
	)
"

DOCS=( README.md changelog/ )

src_configure() {
	# hyprland controls all Hyprland sub-features as a group.
	# i3 controls I3/Sway IPC.
	# niri controls Niri IPC.
	# screencopy controls all screencopy backends (icc, wlr, hyprland-toplevel).
	local _hyprland=$(usex hyprland)
	local _i3=$(usex i3)
	local _niri=$(usex niri)
	local _screencopy=$(usex screencopy)

	local mycmakeargs=(
		-DDISTRIBUTOR="${BRANDING_OS_NAME} GURU"
		-DINSTALL_QML_PREFIX="$(get_libdir)/qt6/qml"
		-DGIT_REVISION=${GIT_REVISION}
		-DCRASH_HANDLER=no # dev-cpp/cpptrace::gentoo does not have required use flags
		-DBLUETOOTH=$(usex bluetooth)
		-DDWL=$(usex dwl)
		-DHYPRLAND=${_hyprland}
		-DHYPRLAND_FOCUS_GRAB=${_hyprland}
		-DHYPRLAND_GLOBAL_SHORTCUTS=${_hyprland}
		-DHYPRLAND_IPC=${_hyprland}
		-DHYPRLAND_SURFACE_EXTENSIONS=${_hyprland}
		-DI3=${_i3}
		-DI3_IPC=${_i3}
		-DNETWORK=$(usex networkmanager)
		-DNIRI=${_niri}
		-DNIRI_IPC=${_niri}
		-DSCREENCOPY=${_screencopy}
		-DSCREENCOPY_HYPRLAND_TOPLEVEL=${_screencopy}
		-DSCREENCOPY_ICC=${_screencopy}
		-DSCREENCOPY_WLR=${_screencopy}
		-DSERVICE_GREETD=$(usex greetd)
		-DSERVICE_MPRIS=$(usex mpris)
		-DSERVICE_NOTIFICATIONS=$(usex notifications)
		-DSERVICE_PAM=$(usex pam)
		-DSERVICE_PIPEWIRE=$(usex pipewire)
		-DSERVICE_POLKIT=$(usex policykit)
		-DSERVICE_STATUS_NOTIFIER=$(usex tray)
		-DSERVICE_UPOWER=$(usex upower)
		-DSOCKETS=$(usex sockets)
		-DUSE_JEMALLOC=$(usex jemalloc)
		-DWAYLAND=$(usex wayland)
		-DWAYLAND_SESSION_LOCK=$(usex session-lock)
		-DWAYLAND_TOPLEVEL_MANAGEMENT=$(usex toplevel-management)
		-DWAYLAND_WLR_LAYERSHELL=$(usex layer-shell)
		-DX11=$(usex X)
	)
	cmake_src_configure
}
