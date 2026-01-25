# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature systemd

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
	insopts -m0755
	doins -r .

	systemd_douserunit Assets/Services/systemd/noctalia.service
}

pkg_postinst() {
	elog "Noctalia Quickshell configuration has been installed to /etc/xdg/quickshell/noctalia-shell."
	elog "Note: uninstalling this package will not remove this configuration, so if you intend to keep using Quickshell you may want to remove it manually."
	elog "For integration with systemd a user service unit has been installed to /usr/lib/systemd/user/noctalia.service."

	optfeature "clipboard history support" app-misc/cliphist
	optfeature "audio visualizer component" media-sound/cava
	optfeature "night light functionality" gui-apps/wlsunset
	optfeature "enable 'Portal' option in screen recorder" sys-apps/xdg-desktop-portal
	optfeature "calendar events support" gnome-extra/evolution-data-server
	optfeature "power profile management" sys-power/power-profiles-daemon
	optfeature "external display brightness control" app-misc/ddcutil
}
