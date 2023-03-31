# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="TypeScript & JavaScript Language Server"
HOMEPAGE="https://www.npmjs.com/package/typescript-language-server"
SRC_URI="mirror://npm/${PN}/-/${P}.tgz"
S="${WORKDIR}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	net-libs/nodejs
"
BDEPEND="
	net-libs/nodejs[npm]
	>=dev-lang/typescript-4.9.5
"

src_unpack() {
	: # npm uses the archive directly
}

src_install() {
	npm \
		--offline \
		--verbose \
		--progress false \
		--foreground-scripts \
		--global \
		--prefix "${ED}"/usr \
		--cache "${T}"/npm-cache \
		install "${DISTDIR}"/${P}.tgz || die "npm install failed"

	cd "${ED}"/usr/$(get_libdir)/node_modules/${PN} || die "cd failed"
	einstalldocs
}
