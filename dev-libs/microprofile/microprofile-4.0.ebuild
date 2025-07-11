# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="An embeddable profiler"
HOMEPAGE="https://github.com/jonasmr/microprofile"
SRC_URI="https://github.com/jonasmr/microprofile/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/stb"
BDEPEND="virtual/pkgconfig"
