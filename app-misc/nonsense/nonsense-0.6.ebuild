# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Generates random text from datafiles and templates"
HOMEPAGE="https://nonsense.sourceforge.net"
SRC_URI="mirror://sourceforge/nonsense/nonsense-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	dobin nonsense
	dodoc README CHANGELOG
	insinto /usr/share/nonsense
	doins *.data *.html *.template
}
