# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SRC_URI="https://github.com/coldnew/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
DESCRIPTION="Manage the valac symlink"
HOMEPAGE="https://github.com/coldnew/eselect-vala"
LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"

RDEPEND="app-admin/eselect"

S="${WORKDIR}/${P}"

src_install() {
	default
	insinto /usr/share/eselect/modules
	doins vala.eselect
}
