# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MPV_REQ_USE="cplugins(+),libmpv"
inherit mpv-plugin toolchain-funcs

DESCRIPTION="MPRIS plugin for mpv"
HOMEPAGE="https://github.com/hoyon/mpv-mpris"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hoyon/${PN}.git"
else
	SRC_URI="https://github.com/hoyon/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
fi

LICENSE="MIT"
IUSE="test"

RDEPEND="
	dev-libs/glib:2
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? (
		app-misc/jq
		app-shells/bash
		app-text/jo
		media-sound/playerctl
		net-misc/socat
		sys-apps/dbus
		app-alternatives/awk
		x11-apps/xauth
		x11-misc/xvfb-run
		x11-themes/sound-theme-freedesktop
	)
"

MPV_PLUGIN_FILES=( mpris.so )

RESTRICT="!test? ( test )"

src_compile() {
	tc-export CC
	emake PKG_CONFIG="$(tc-getPKG_CONFIG)"
}

src_test() {
	emake test
}
