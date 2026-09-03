# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Language Server for YAML Files"
HOMEPAGE="https://github.com/redhat-developer/yaml-language-server"
SRC_URI="
	mirror://npm/${PN}/-/${P}.tgz
	https://git.skysolutions.fi/gentoo-mirror/guru-vendored/releases/download/yaml-language-server-${PV}/yaml-language-server-${PV}-deps.tar.xz
"

S="${WORKDIR}"

# NOTE: to generate the dependency tarball:
#       npm --cache ./npm-cache install $(portageq envvar DISTDIR)/${P}.tgz
#       tar -caf ${P}-deps.tar.xz npm-cache

LICENSE="0BSD Apache-2.0 BSD BSD-2 CC0-1.0 ISC MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-libs/nodejs"
BDEPEND="net-libs/nodejs[npm]"

src_unpack() {
	cd "${T}" || die "Could not cd to temporary directory"
	unpack ${P}-deps.tar.xz
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
