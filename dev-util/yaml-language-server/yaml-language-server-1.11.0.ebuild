# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Language Server for YAML Files"
HOMEPAGE="https://github.com/redhat-developer/yaml-language-server"
SRC_URI="
	mirror://npm/${PN}/-/${P}.tgz
	https://tastytea.de/files/gentoo/${P}-deps.tar.xz
"
S="${WORKDIR}"

# NOTE: to generate the dependency tarball:
#       npm --cache ./npm-cache install $(portageq envvar DISTDIR)/${P}.tgz
#       tar -caf ${P}-deps.tar.xz npm-cache

LICENSE="Apache-2.0 BSD-2 ISC MIT-with-advertising"
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

	einstalldocs
}
