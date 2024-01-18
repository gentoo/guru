# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Spice Javascript client"
HOMEPAGE="https://gitlab.freedesktop.org/spice/spice-html5"
SRC_URI="https://gitlab.freedesktop.org/spice/${PN}/-/archive/${P}/${PN}-${P}.tar.bz2"
S="${WORKDIR}/${PN}-${P}"

LICENSE="LGPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default
	sed -e "s/VERSION/${PV}/" < package.json.in > package.json || die
}

src_install() {
	dodoc README TODO apache.conf.sample
	insinto /usr/share/spice-html5
	doins -r src ./*.html ./*.json ./*.css
}
