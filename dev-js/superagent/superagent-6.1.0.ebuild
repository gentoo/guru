# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="elegant & feature rich browser / node HTTP with a fluent API"
HOMEPAGE="
	https://github.com/visionmedia/superagent
	https://www.npmjs.com/package/superagent
"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/component-emitter
	dev-js/cookiejar
	dev-js/debug
	dev-js/fast-safe-stringify
	dev-js/form-data
	dev-js/formidable
	dev-js/methods
	dev-js/mime
	dev-js/qs
	dev-js/readable-stream
	dev-js/semver
"
HTML_DOCS=( docs/. index.html )

src_install() {
	einstalldocs
	rm -rf docs || die
	node_src_install
}
