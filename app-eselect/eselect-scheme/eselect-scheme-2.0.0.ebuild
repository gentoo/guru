# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Manages scheme implementations"
HOMEPAGE="https://gitweb.gentoo.org/repo/proj/guru.git/tree/app-eselect/eselect-scheme?h=dev"
SRC_URI=""

RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=app-eselect/eselect-lib-bin-symlink-0.1.1
"
DEPEND="${RDEPEND}"

S="${FILESDIR}"

src_install() {
	insinto "/usr/share/eselect/modules"
	newins "scheme.eselect-${PV}" "scheme.eselect"
}

pkg_postinst() {
	eselect scheme update --if-unset
}
