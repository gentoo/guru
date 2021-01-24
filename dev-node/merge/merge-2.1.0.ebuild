# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="(recursive)? merging of (cloned)? objects."
HOMEPAGE="
	https://github.com/yeikos/js.merge
	https://www.npmjs.com/package/merge
"
SRC_URI="https://registry.npmjs.org/merge/-/merge-2.1.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
