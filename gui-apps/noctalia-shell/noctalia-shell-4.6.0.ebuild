# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit optfeature python-single-r1

DESCRIPTION="A sleek and minimal desktop shell thoughtfully crafted for Wayland"
HOMEPAGE="https://noctalia.dev/ https://github.com/noctalia-dev/noctalia-shell"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/noctalia-dev/noctalia-shell.git"
else
	SRC_URI="https://github.com/noctalia-dev/noctalia-shell/releases/download/v${PV}/noctalia-v${PV}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/noctalia-release"
fi

LICENSE="MIT"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	gui-apps/noctalia-qs
	app-misc/brightnessctl
	dev-vcs/git
	media-gfx/imagemagick
"

src_install() {
	insinto /etc/xdg/quickshell/noctalia-shell
	insopts -m0755
	doins -r .

	python_optimize "${ED}/etc/xdg/quickshell/${PN}/Scripts/python/src"
	python_fix_shebang "${ED}/etc/xdg/quickshell/${PN}/Scripts/python/src"
}

pkg_postinst() {
	optfeature "clipboard history support" app-misc/cliphist
	optfeature "audio visualizer component" media-sound/cava
	optfeature "night light functionality" gui-apps/wlsunset
	optfeature "enable 'Portal' option in screen recorder" sys-apps/xdg-desktop-portal
	optfeature "calendar events support" gnome-extra/evolution-data-server
	optfeature "power profile management" sys-power/power-profiles-daemon
	optfeature "external display brightness control" app-misc/ddcutil
}
