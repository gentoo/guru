# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Port of the OpenBSD bcrypt_pbkdf function to pure JS"
HOMEPAGE="
	https://github.com/joyent/node-bcrypt-pbkdf
	https://www.npmjs.com/package/bcrypt-pbkdf
"

LICENSE="BSD"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/tweetnacl
"
