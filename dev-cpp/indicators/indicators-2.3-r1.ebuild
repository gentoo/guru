# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Activity indicators for modern C++"
HOMEPAGE="https://github.com/p-ranav/indicators"
SRC_URI="https://github.com/p-ranav/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

PATCHES=( "${FILESDIR}"/${P}-include.patch )

QA_PKGCONFIG_VERSION="${PV}.0"

src_install() {
	cmake_src_install
	rm -r "${ED}"/usr/share/licenses || die

	docompress -x /usr/share/doc/${PF}/samples
	use examples && dodoc -r demo samples
}
