# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="A node.js module for parsing form data, especially file uploads."
HOMEPAGE="
	https://github.com/node-formidable/formidable
	https://www.npmjs.com/package/formidable
"
SRC_URI="https://registry.npmjs.org/formidable/-/formidable-1.2.2.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
