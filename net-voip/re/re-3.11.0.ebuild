# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Generic library for real-time communications with async IO support"
HOMEPAGE="https://github.com/baresip/re"
SRC_URI="https://github.com/baresip/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="static-libs"

src_configure() {
		local mycmakeargs=(
				-DLIBRE_BUILD_STATIC=$(usex static-libs ON OFF)
		)
		cmake_src_configure
}
