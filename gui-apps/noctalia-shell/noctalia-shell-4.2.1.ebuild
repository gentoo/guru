# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd
inherit optfeature

DESCRIPTION="Noctalia Configuration for Quickshell"
HOMEPAGE="https://github.com/noctalia-dev/noctalia-shell"
SRC_URI="https://github.com/noctalia-dev/noctalia-shell/releases/download/v${PV}/noctalia-v${PV}.tar.gz"

S="${WORKDIR}/noctalia-release"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	gui-apps/quickshell
	app-misc/brightnessctl
	dev-vcs/git
	media-gfx/imagemagick
"

src_install() {
	insinto /etc/xdg/quickshell/noctalia-shell
	doins -r .
	fperms 0755 "/etc/xdg/quickshell/noctalia-shell/Scripts/bash/template-apply.sh"

	systemd_douserunit Assets/Services/systemd/noctalia.service
}

pkg_postinst() {
	elog "Noctalia Quickshell configuration has been installed to /etc/xdg/quickshell/noctalia-shell."
	elog "Note: uninstalling this package will not remove this configuration, so if you intend to keep using Quickshell you may want to remove it manually."
	elog "For integration with systemd a user service unit has been installed to /usr/lib/systemd/user/noctalia.service."

	optfeature "Clipboard history support" app-misc/cliphist
	optfeature "Audio visualizer component" media-sound/cava
	optfeature "Night light functionality" gui-apps/wlsunset
	optfeature "Enable 'Portal' option in screen recorder" sys-apps/xdg-desktop-portal
	optfeature "Calendar events support" gnome-extra/evolution-data-server
	optfeature "Xwayland-satellite for xwayland support on niri" gui-apps/xwayland-satellite
}
