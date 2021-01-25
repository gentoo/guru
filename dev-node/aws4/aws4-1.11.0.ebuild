# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="Signs and prepares requests using AWS Signature Version 4"
HOMEPAGE="
	https://github.com/mhart/aws4
	https://www.npmjs.com/package/aws4
"
SRC_URI="https://registry.npmjs.org/aws4/-/aws4-1.11.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
