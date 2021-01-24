# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="A library to create readable "multipart/form-data" streams. Can be used to submit forms and file uploads to other web applications."
HOMEPAGE="
	https://github.com/form-data/form-data
	https://www.npmjs.com/package/form-data
"
SRC_URI="https://registry.npmjs.org/form-data/-/form-data-3.0.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
	dev-node/asynckit
	dev-node/combined-stream
	dev-node/mime-types
"
