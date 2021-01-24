# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Tools for debugging your node.js modules and event loop"
HOMEPAGE="
	https://github.com/3rd-Eden/diagnostics
	https://www.npmjs.com/package/@dabh/diagnostics
"
SRC_URI="https://registry.npmjs.org/@dabh/diagnostics/-/diagnostics-2.0.2.tgz -> ${P}.tgz"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/@dabh/diagnostics"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}