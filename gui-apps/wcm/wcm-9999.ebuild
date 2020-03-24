# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Wayfire Config Manager"
HOMEPAGE="https://github.com/WayfireWM/wcm"
EGIT_REPO_URI="https://github.compu/WayfireWM/wcm.git"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/WayfireWM/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/WayfireWM/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	dev-libs/libevdev
	dev-libs/libxml2
	dev-cpp/gtkmm:3.0[wayland]
	~gui-apps/wf-config-${PV}
	~gui-wm/wayfire-${PV}
"

RDEPEND="
	${DEPEND}
"

BDEPEND="
	${DEPEND}
	virtual/pkgconfig
	dev-libs/wayland-protocols
"
