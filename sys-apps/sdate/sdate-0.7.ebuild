# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Wrapper program to output dates like the Eternal September 1993"
HOMEPAGE="https://www.df7cb.de/projects/sdate/"
SRC_URI="https://github.com/df7cb/sdate/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
	find "${ED}" -name '*.a' -delete || die
}
