# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Yet Another Linked List"
HOMEPAGE="
	https://github.com/isaacs/yallist
	https://www.npmjs.com/package/yallist
"
SRC_URI="https://registry.npmjs.org/yallist/-/yallist-4.0.0.tgz"
LICENSE="ISC"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}