# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson optfeature tmpfiles

DESCRIPTION="A minimal login greeter for greetd that matches Noctalia Shell"
HOMEPAGE="https://noctalia.dev/ https://github.com/noctalia-dev/noctalia-greeter"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/noctalia-dev/${PN}.git"
else
	SRC_URI="https://github.com/noctalia-dev/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
	dev-cpp/tomlplusplus
	dev-cpp/nlohmann_json
	dev-libs/glib:2
	dev-libs/libinput
	dev-libs/wayland
	dev-libs/stb
	gnome-base/librsvg:2
	gui-libs/greetd
	gui-libs/wlroots:0.20=
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libwebp
	media-libs/mesa
	sys-apps/dbus
	virtual/opengl
	x11-libs/cairo[glib]
	x11-libs/libxkbcommon
	x11-libs/pango
"

RDEPEND="${DEPEND}"

BDEPEND="
	dev-libs/wayland
	dev-util/wayland-scanner
	dev-libs/wayland-protocols
"

# TODO: unbundle tabler fonts

src_prepare() {
	default

	# replace greetd user
	sed -E -i 's/^(\S+\s+\S+\s+\S+\s+)greeter(\s+)greeter(\s+)/\1greetd\2greetd\3/' data/tmpfiles.d/${PN}.conf
}

src_install() {
	meson_src_install

	# remove unneeded additional scripts
	rm "${ED}"/usr/share/${PN}/*.sh || die

	dotmpfiles data/tmpfiles.d/${PN}.conf
}

pkg_postinst() {
	tmpfiles_process ${PN}.conf

	optfeature "avatars" sys-apps/accountsservice
}
