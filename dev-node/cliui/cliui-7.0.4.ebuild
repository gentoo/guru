# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="easily create complex multi-column command-line-interfaces"
HOMEPAGE="
	https://github.com/yargs/cliui
	https://www.npmjs.com/package/cliui
"
SRC_URI="https://registry.npmjs.org/cliui/-/cliui-7.0.4.tgz"
LICENSE="ISC"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/string-width
	dev-node/strip-ansi
	dev-node/wrap-ansi
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}