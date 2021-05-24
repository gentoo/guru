# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A lightweight overlay volume/backlight/progress/anything bar for Wayland."
HOMEPAGE="https://github.com/francma/wob"
SRC_URI="https://github.com/francma/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/wayland"
RDEPEND="${DEPEND}"
BDEPEND=""
