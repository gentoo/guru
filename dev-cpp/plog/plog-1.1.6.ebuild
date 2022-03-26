# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Portable, simple and extensible C++ logging library"
HOMEPAGE="https://github.com/SergiusTheBest/plog"
SRC_URI="https://github.com/SergiusTheBest/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="MPL-2.0"
SLOT="0"
IUSE="examples"

src_install() {
	doheader -r "include/${PN}"
	dodoc README.md
	insinto "/usr/share/${P}/samples"
	use examples && doins -r samples/.
}
