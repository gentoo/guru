# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Minimal and efficient cross-platform file watching library"
HOMEPAGE="
	https://github.com/paulmillr/chokidar
	https://www.npmjs.com/package/chokidar
"
SRC_URI="https://registry.npmjs.org/chokidar/-/chokidar-3.5.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/anymatch
	dev-node/braces
	dev-node/glob-parent
	dev-node/is-binary-path
	dev-node/is-glob
	dev-node/normalize-path
	dev-node/readdirp
	dev-node/fsevents
"
