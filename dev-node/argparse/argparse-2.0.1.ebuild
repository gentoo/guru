# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="CLI arguments parser. Native port of python's argparse."
HOMEPAGE="
	https://github.com/nodeca/argparse
	https://www.npmjs.com/package/argparse
"
SRC_URI="https://registry.npmjs.org/argparse/-/argparse-2.0.1.tgz -> ${P}.tgz"
LICENSE="PSF-2"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/argparse"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}
