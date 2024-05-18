# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Manage the ld symlink"
HOMEPAGE="https://codeberg.org/mmatous/eselect-ld"
SRC_URI="https://codeberg.org/mmatous/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror"

RDEPEND="app-admin/eselect"

src_install() {
	default
	insinto /usr/share/eselect/modules
	doins ld.eselect
}
