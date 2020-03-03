# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

COMMIT="1d45e07cfa7ceed69fb7302cfd0f3e2d2453e115"

SRC_URI="https://github.com/z411/vrms-gentoo/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
DESCRIPTION="vrms clone for Gentoo Linux"
HOMEPAGE="https://github.com/z411/vrms-gentoo"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="dev-lang/perl"

DOCS=( README.md )

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	dobin "${PN}"
}
