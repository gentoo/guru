# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A simple async wrapper around CURL for C++"
HOMEPAGE="https://nheko.im/nheko-reborn/coeurl"
SRC_URI="https://nheko.im/nheko-reborn/coeurl/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="MIT"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64"
IUSE="ssl test"
RESTRICT="test" # Tests turned off because they need a local webserver.

RDEPEND="
	net-misc/curl[ssl?]
	dev-libs/libevent
	dev-libs/libfmt:=
	dev-libs/spdlog
"
DEPEND="
	${RDEPEND}
	test? ( dev-cpp/doctest )
"

src_configure() {
	local -a emesonargs=(
		$(meson_use test tests)
	)
	meson_src_configure
}
