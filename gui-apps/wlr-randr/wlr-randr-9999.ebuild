# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="xrandr clone for wlroots compositors"
HOMEPAGE="https://github.com/emersion/wlr-randr"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/emersion/wlr-randr"
else
	SRC_URI="https://github.com/emersion/wlr-randr/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="ISC"
SLOT="0"

DEPEND="
	dev-libs/wayland
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	virtual/pkgconfig
"

src_prepare() {
	default
	sed -i 's/werror=true/werror=false/' meson.build || die
}
