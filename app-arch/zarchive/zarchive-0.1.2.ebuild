# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Library for creating and reading zstd-compressed file archives (.zar)"
HOMEPAGE="https://github.com/Exzap/ZArchive"
SRC_URI="https://github.com/Exzap/ZArchive/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="app-arch/zstd"
RDEPEND="${DEPEND}"

S="${WORKDIR}/ZArchive-${PV}"
