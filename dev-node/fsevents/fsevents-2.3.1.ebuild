# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Native Access to MacOS FSEvents"
HOMEPAGE="
	https://github.com/fsevents/fsevents
	https://www.npmjs.com/package/fsevents
"
SRC_URI="https://registry.npmjs.org/fsevents/-/fsevents-2.3.1.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
