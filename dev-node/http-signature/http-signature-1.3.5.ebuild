# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Reference implementation of Joyent's HTTP Signature scheme."
HOMEPAGE="
	https://github.com/joyent/node-http-signature/
	https://www.npmjs.com/package/http-signature
"
SRC_URI="https://registry.npmjs.org/http-signature/-/http-signature-1.3.5.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/assert-plus
	dev-node/jsprim
	dev-node/sshpk
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}