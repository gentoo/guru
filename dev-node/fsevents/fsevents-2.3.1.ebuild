# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Native Access to MacOS FSEvents"
HOMEPAGE="
	https://github.com/fsevents/fsevents
	https://www.npmjs.com/package/fsevents
"
SRC_URI="https://registry.npmjs.org/fsevents/-/fsevents-2.3.1.tgz"
LICENSE="MIT"
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