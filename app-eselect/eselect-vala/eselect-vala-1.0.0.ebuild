# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Manage the valac symlink"
HOMEPAGE="https://github.com/coldnew/eselect-vala"
SRC_URI="https://github.com/coldnew/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror"

RDEPEND="app-admin/eselect"

src_install() {
	default
	insinto /usr/share/eselect/modules
	doins vala.eselect
}
