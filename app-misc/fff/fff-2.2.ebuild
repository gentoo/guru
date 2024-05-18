# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A simple file manager written in bash"
HOMEPAGE="https://github.com/dylanaraps/fff"
SRC_URI="https://github.com/dylanaraps/fff/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	dobin "fff"
	doman "fff.1"
	dodoc "README.md"
}
