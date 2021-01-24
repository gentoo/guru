# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Return the filename and line number of the calling function"
HOMEPAGE="
	https://github.com/sideway/pinpoint
	https://www.npmjs.com/package/@sideway/pinpoint
"
SRC_URI="https://registry.npmjs.org/@sideway/pinpoint/-/pinpoint-2.0.0.tgz -> ${P}.tgz"
LICENSE="BSD"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/@sideway/pinpoint"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}