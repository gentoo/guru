# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node-guru

DESCRIPTION="[![Build Status](https://travis-ci.org/stefanpenner/get-caller-file.svg?branch=master)](https://travis-ci.org/stefanpenner/get-caller-file) [![Build status](https://ci.appveyor.com/api/projects/status/ol2q94g1932cy14a/branch/master?svg=true)](https://ci.a"
HOMEPAGE="
	https://github.com/stefanpenner/get-caller-file
	https://www.npmjs.com/package/get-caller-file
"
SRC_URI="https://registry.npmjs.org/get-caller-file/-/get-caller-file-2.0.5.tgz"
LICENSE="ISC"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
