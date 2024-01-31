# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${PN}-v${PV}"

DESCRIPTION="Tiny system info for Unix-like operating systems"
HOMEPAGE="https://gitlab.com/jschx/ufetch"
SRC_URI="https://gitlab.com/jschx/ufetch/-/archive/v${PV}/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	newbin ufetch-gentoo ufetch
}
