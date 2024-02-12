# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A pretty system information tool written in POSIX sh"
HOMEPAGE="https://github.com/dylanaraps/pfetch"

KEYWORDS="~amd64 ~arm64 ~x86"
SRC_URI="https://github.com/dylanaraps/pfetch/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"

src_install() {
	dobin "${PN}"
}
