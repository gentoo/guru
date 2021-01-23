# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Colored symbols for various log levels."
HOMEPAGE="
	https://github.com/sindresorhus/log-symbols
	https://www.npmjs.com/package/log-symbols
"
SRC_URI="https://registry.npmjs.org/log-symbols/-/log-symbols-4.0.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/chalk
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}
