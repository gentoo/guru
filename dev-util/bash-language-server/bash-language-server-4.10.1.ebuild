# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="A language server for Bash"
HOMEPAGE="https://github.com/bash-lsp/bash-language-server"
SRC_URI="
	mirror://npm/${PN}/-/${P}.tgz
	https://tastytea.de/files/gentoo/${P}-deps.tar.xz
"
S="${WORKDIR}"

# NOTE: to generate the dependency tarball:
#       npm --cache ./npm-cache install $(portageq envvar DISTDIR)/${P}.tgz
#       tar -caf ${P}-deps.tar.xz npm-cache

LICENSE="
	Apache-2.0 BSD BSD-2 CC0-1.0 ISC MIT-with-advertising
	|| ( public-domain Unlicense )
"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=net-libs/nodejs-18.16.18"
BDEPEND=">=net-libs/nodejs-18.16.18[npm]"

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

pkg_postinst() {
	optfeature "linting support" dev-util/shellcheck dev-util/shellcheck-bin
}
