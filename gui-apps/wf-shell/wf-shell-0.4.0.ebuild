# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A compiz like 3D wayland compositor"
HOMEPAGE="https://github.com/WayfireWM/wf-shell"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WayfireWM/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/WayfireWM/${PN}/releases/download/${PV}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="pulseaudio"

DEPEND="
	~gui-apps/wf-config-${PV}
	dev-cpp/gtkmm:3.0=[wayland]
	dev-libs/gobject-introspection
	pulseaudio? ( media-sound/pulseaudio )
	~gui-wm/wayfire-${PV}
	>=gui-libs/gtk-layer-shell-0.1
"

RDEPEND="
	${DEPEND}
"

BDEPEND="
	virtual/pkgconfig
	dev-libs/wayland-protocols
"

src_configure () {
	local emesonargs=(
		"-Dpulse=$(usex pulseaudio enabled disabled)"
	)
	meson_src_configure
}
