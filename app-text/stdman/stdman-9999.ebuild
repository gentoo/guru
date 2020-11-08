# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Formatted C++ stdlib man pages (cppreference)"
HOMEPAGE="https://github.com/jeaye/stdman"
LICENSE="MIT"

SLOT="0"
IUSE=""

RDEPEND=""

PATCHES=( "${FILESDIR}/${PN}-dont-compress-files.patch" )

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jeaye/stdman"
fi

src_compile() {
	# don't need to compile anything
	true
}
