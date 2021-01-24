# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="AWS signing. Originally pulled from LearnBoost/knox, maintained as vendor in request, now a standalone module."
HOMEPAGE="
	https://github.com/mikeal/aws-sign
	https://www.npmjs.com/package/aws-sign2
"
SRC_URI="https://registry.npmjs.org/aws-sign2/-/aws-sign2-0.7.0.tgz"
LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	app-misc/jq
	sys-apps/moreutils
"
S="${WORKDIR}"

src_prepare() {
	jq '.dependencies[] = "*"' package/package.json | sponge package/package.json || die
	default
}

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}