# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="CSV parsing implementing the Node.js stream.Transform API"
HOMEPAGE="
	https://csv.js.org/parse/
	https://www.npmjs.com/package/csv-parse
"
SRC_URI="https://registry.npmjs.org/csv-parse/-/csv-parse-4.15.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
