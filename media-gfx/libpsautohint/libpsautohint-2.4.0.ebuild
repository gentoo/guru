# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PN="${PN#lib}"
DESCRIPTION="A library for autohinting PostScript fonts"
HOMEPAGE="https://github.com/adobe-type-tools/psautohint"
SRC_URI="https://github.com/adobe-type-tools/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default
	sed "/-Werror/d" -i meson.build || die
}

src_install() {
	meson_src_install
	doheader include/*.h
}
