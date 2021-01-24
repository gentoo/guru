# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Minimal async jobs utility library, with streams support"
HOMEPAGE="
	https://github.com/alexindigo/asynckit
	https://www.npmjs.com/package/asynckit
"
SRC_URI="https://registry.npmjs.org/asynckit/-/asynckit-0.4.0.tgz -> ${P}.tgz"
LICENSE="MIT"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/asynckit"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}