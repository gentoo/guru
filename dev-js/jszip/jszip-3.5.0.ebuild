# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Create, read and edit .zip files with JavaScript http://stuartk.com/jszip"
HOMEPAGE="
	https://github.com/Stuk/jszip
	https://www.npmjs.com/package/jszip
"

LICENSE="|| ( MIT GPL-3 )"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/lie
	dev-js/pako
	dev-js/readable-stream
	dev-js/set-immediate-shim
"
