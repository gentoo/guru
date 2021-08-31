# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="grow bonsai trees in your terminal"
HOMEPAGE="https://gitlab.com/jallbrit/cbonsai"
SRC_URI="https://gitlab.com/jallbrit/cbonsai/-/archive/v${PV}/cbonsai-v${PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	app-text/scdoc
	virtual/pkgconfig
"

PATCHES=( "${FILESDIR}/${PN}-respect-variables.patch" )

src_compile() {
	emake cbonsai
	emake cbonsai.1
}

src_install() {
	PREFIX="${EPREFIX}/usr" DESTDIR="${D}" emake install
}
