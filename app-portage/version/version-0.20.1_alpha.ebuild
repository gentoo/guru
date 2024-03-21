# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

MYPV="${PV/_alpha/-alpha}"

DESCRIPTION="A command line function for package version  management."
HOMEPAGE="https://github.com/azaeldevel/octetos-version"
SRC_URI="https://github.com/azaeldevel/octetos-${PN}/archive/${MYPV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"


DEPEND="dev-libs/octetos-coreutils"
RDEPEND="${DEPEND}"

S="${WORKDIR}/octetos-${PN}-${MYPV}"

src_prepare() {
	default
	eautoreconf -fi
}
src_configure() {
	econf --with-portage
}
