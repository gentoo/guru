# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Growl unobtrusive notifications"
HOMEPAGE="
	https://github.com/tj/node-growl
	https://www.npmjs.com/package/growl
"
SRC_URI="https://registry.npmjs.org/growl/-/growl-1.10.5.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
