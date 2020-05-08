# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

COMMIT="fda4a26c26b2d1b2beb68d7b92b56950ec2b8ad2"

DESCRIPTION="Portable, simple and extensible C++ logging library"
HOMEPAGE="https://github.com/SergiusTheBest/plog"
SRC_URI="https://github.com/SergiusTheBest/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="MPL-2.0"
SLOT="0"
IUSE="examples"

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	doheader -r "include/${PN}"
	dodoc README.md
	insinto "/usr/share/${P}/samples"
	use examples && doins -r samples/.
}
