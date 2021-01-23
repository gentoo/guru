# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="the bare-bones internationalization library used by yargs"
HOMEPAGE="
	https://github.com/yargs/y18n
	https://www.npmjs.com/package/y18n
"
SRC_URI="https://registry.npmjs.org/y18n/-/y18n-5.0.5.tgz"
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