# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Small system information script for linux systems."

HOMEPAGE="https://github.com/its-Lyn/lyfetch"
SRC_URI="https://github.com/its-Lyn/lyfetch/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT=0

KEYWORDS="~amd64"

src_install() {
	dobin "${PN}"
}
