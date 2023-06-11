# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="${PN}-nodejs-${PV}"

DESCRIPTION="A language server for Dockerfiles"
HOMEPAGE="https://github.com/rcjsuen/dockerfile-language-server-nodejs"
SRC_URI="
	mirror://npm/${PN}-nodejs/-/${MY_P}.tgz
	https://tastytea.de/files/gentoo/${P}-deps.tar.xz
"
S="${WORKDIR}"

# NOTE: to generate the dependency tarball:
#       npm --cache "$(realpath ./npm-cache)" install $(portageq envvar DISTDIR)/${MY_P}.tgz
#       tar -caf ${P}-deps.tar.xz npm-cache

LICENSE="MIT-with-advertising"
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
		install "${DISTDIR}"/${MY_P}.tgz || die "npm install failed"

	einstalldocs
}
