# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A language server for Dockerfiles"
HOMEPAGE="https://github.com/rcjsuen/dockerfile-language-server"
SRC_URI="
	https://github.com/rcjsuen/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://codeberg.org/ceres-sees-all/guru-distfiles/releases/download/${P}-deps.tar.gz/${P}-deps.tar.gz
"

S=${WORKDIR}

# NOTE: to generate the dependency tarball:
#       npm --cache "$(realpath ./npm-cache)" install $(portageq envvar DISTDIR)/${MY_P}.tgz
#       tar -caf ${P}-deps.tar.xz npm-cache

LICENSE="MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="net-libs/nodejs"
BDEPEND="net-libs/nodejs[npm]"

src_unpack() {
	unpack ${P}-deps.tar.gz
}

src_install() {
	npm \
		--offline \
		--verbose \
		--progress false \
		--foreground-scripts \
		--global \
		--prefix "${ED}/usr" \
		--cache "${WORKDIR}/npm-cache" \
		install "${DISTDIR}/${P}.tar.gz" || die "npm install failed"

	einstalldocs
}
