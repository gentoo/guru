# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools pam

DESCRIPTION="Unlock GnuPG keys on login"
HOMEPAGE="https://github.com/cruegge/pam-gnupg"
SRC_URI="https://github.com/cruegge/pam-gnupg/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=sys-libs/pam-1.6.1
	>=app-crypt/gnupg-2.4.5-r1
"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf --with-moduledir="$(getpam_mod_dir)"
}
