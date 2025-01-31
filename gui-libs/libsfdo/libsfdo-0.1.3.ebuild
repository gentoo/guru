# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A collection of libraries which implement some freedesktop.org specifications"
HOMEPAGE="https://gitlab.freedesktop.org/vyivel/libsfdo"
SRC_URI="https://gitlab.freedesktop.org/vyivel/libsfdo/-/archive/v${PV}/libsfdo-v${PV}.tar.bz2"

# necessary because packaged dir contains a v before version number
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples test"
RESTRICT="!test? ( test )"

BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		$(meson_use examples)
		$(meson_use test tests)
	)
	meson_src_configure
}
