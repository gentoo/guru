# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="OAuth 1 signing. Formerly a vendor lib in mikeal/request, now a standalone module."
HOMEPAGE="
	https://github.com/mikeal/oauth-sign
	https://www.npmjs.com/package/oauth-sign
"
SRC_URI="https://registry.npmjs.org/oauth-sign/-/oauth-sign-0.9.0.tgz"
LICENSE="Apache-2.0"
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