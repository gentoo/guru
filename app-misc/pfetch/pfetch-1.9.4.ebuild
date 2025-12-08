# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A pretty system information tool written in POSIX sh"
HOMEPAGE="https://github.com/Un1q32/pfetch"
SRC_URI="https://github.com/Un1q32/pfetch/archive/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install
	dodoc README*
}
