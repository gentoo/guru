# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="HTTP proxy tunneling agent. Formerly part of mikeal/request, now a standalone module."
HOMEPAGE="
	https://github.com/mikeal/tunnel-agent
	https://www.npmjs.com/package/tunnel-agent
"
SRC_URI="https://registry.npmjs.org/tunnel-agent/-/tunnel-agent-0.6.0.tgz"
LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/safe-buffer
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}