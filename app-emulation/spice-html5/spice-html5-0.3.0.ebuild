# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Spice Javascript client"
HOMEPAGE="https://gitlab.freedesktop.org/spice/spice-html5"
SRC_URI="https://gitlab.freedesktop.org/spice/${PN}/-/archive/${P}/${PN}-${P}.tar.gz"
S="${WORKDIR}/${PN}-${P}"

LICENSE="LGPL-3" # maybe other licenses
SLOT="0"
KEYWORDS="~amd64"

# no compiling
src_compile() {
	true
}

src_install() {
	dodoc README
	insinto /usr/share/spice-html5
	doins -r src apache.conf.sample spice.css spice.html spice_auto.html
}
