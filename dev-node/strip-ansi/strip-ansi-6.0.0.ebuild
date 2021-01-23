# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Strip ANSI escape codes from a string"
HOMEPAGE="
	https://github.com/chalk/strip-ansi
	https://www.npmjs.com/package/strip-ansi
"
SRC_URI="https://registry.npmjs.org/strip-ansi/-/strip-ansi-6.0.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/ansi-regex
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}