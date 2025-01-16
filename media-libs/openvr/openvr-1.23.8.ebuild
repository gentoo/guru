# Copyright 2020-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8
EGIT_REPO_URI="https://github.com/ValveSoftware/openvr"

inherit cmake-multilib

DESCRIPTION="OpenVR SDK"
HOMEPAGE="https://steamvr.com"

SRC_URI="${EGIT_REPO_URI}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="static"

PATCHES=(
	"${FILESDIR}/${PN}-libdir.patch"
)

DOCS=(
	"${S}/LICENSE"
	"${S}/README.md"
)

src_configure() {
	my_configure() {
		mycmakeargs=(
			-DBUILD_SHARED="$(usex static OFF ON)"
		)
		cmake_src_configure
	}
	multilib_parallel_foreach_abi my_configure
}
