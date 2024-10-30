# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="XVA virtual disk tool, supports exporting XVA to RAW."
HOMEPAGE="https://github.com/eriklax/xva-img"
SRC_URI="https://github.com/eriklax/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/xxhash"
RDEPEND="${DEPEND}"
