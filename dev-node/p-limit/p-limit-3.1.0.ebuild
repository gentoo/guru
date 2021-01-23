# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Run multiple promise-returning & async functions with limited concurrency"
HOMEPAGE="
	https://github.com/sindresorhus/p-limit
	https://www.npmjs.com/package/p-limit
"
SRC_URI="https://registry.npmjs.org/p-limit/-/p-limit-3.1.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/yocto-queue
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}