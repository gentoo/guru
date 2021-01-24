# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="List of binary file extensions"
HOMEPAGE="
	https://github.com/sindresorhus/binary-extensions
	https://www.npmjs.com/package/binary-extensions
"
SRC_URI="https://registry.npmjs.org/binary-extensions/-/binary-extensions-2.2.0.tgz -> ${P}.tgz"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/binary-extensions"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}