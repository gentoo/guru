# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A simple notification daemon with a GTK gui for notifications and control center"
HOMEPAGE="https://github.com/ErikReider/SwayNotificationCenter"
SRC_URI="https://github.com/ErikReider/SwayNotificationCenter/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/SwayNotificationCenter-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion fish-completion scripting systemd zsh-completion"

DEPEND="
	dev-libs/glib
	dev-libs/gobject-introspection
	dev-libs/json-glib
	dev-libs/libgee
	dev-libs/wayland
	gui-libs/gtk-layer-shell
	gui-libs/libhandy
	sys-apps/dbus
	x11-libs/gtk+:3
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-lang/vala
	dev-util/meson
"

src_configure() {
	local emesonargs=(
		$(meson_use bash-completion bash-completions)
		$(meson_use fish-completion fish-completions)
		$(meson_use scripting)
		$(meson_use systemd systemd-service)
		$(meson_use zsh-completion zsh-completions)
	)
	meson_src_configure
}
