# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Manages Swift symlinks"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"

S="${WORKDIR}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-admin/eselect"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${FILESDIR}/swift-${PV}.eselect" swift.eselect || die
}

pkg_postinst() {
	eselect swift update
}
