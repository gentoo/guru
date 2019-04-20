# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit fcaps meson

DESCRIPTION="A lightweight Wayland notification daemon"
HOMEPAGE="https://wayland.emersion.fr/mako https://github.com/emersion/mako"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/emersion/${PN}.git"
else
	SRC_URI="https://github.com/emersion/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="apparmor elogind +gdk-pixbuf +man systemd zsh-completion"
REQUIRED_USE="?? ( elogind systemd )"

DEPEND="
	dev-libs/wayland
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pango
	elogind? ( >=sys-auth/elogind-239 )
	gdk-pixbuf? ( x11-libs/gdk-pixbuf:2 )
	systemd? ( >=sys-apps/systemd-239 )
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
	man? ( app-text/scdoc )
"

src_configure() {
	local emesonargs=(
		-Dicons=$(usex gdk-pixbuf enabled disabled)
		-Dman-pages=$(usex man enabled disabled)
		$(meson_use apparmor apparmor)
		$(meson_use zsh-completion zsh-completions)
		"-Dwerror=false"
	)

	meson_src_configure
}
