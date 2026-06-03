# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A compression utility based on Brotli algorithm"
HOMEPAGE="https://gitlab.com/ms1888/brzip"
SRC_URI="https://gitlab.com/ms1888/brzip/-/archive/${PV}/${P}.tar.bz2"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-arch/brotli:=
	dev-libs/xxhash:="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"
