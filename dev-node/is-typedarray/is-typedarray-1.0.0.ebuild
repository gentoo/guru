# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Detect whether or not an object is a Typed Array"
HOMEPAGE="
	https://github.com/hughsk/is-typedarray
	https://www.npmjs.com/package/is-typedarray
"
SRC_URI="https://registry.npmjs.org/is-typedarray/-/is-typedarray-1.0.0.tgz"
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