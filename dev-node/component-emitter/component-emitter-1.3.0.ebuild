# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Event emitter"
HOMEPAGE="
	https://github.com/component/emitter
	https://www.npmjs.com/package/component-emitter
"
SRC_URI="https://registry.npmjs.org/component-emitter/-/component-emitter-1.3.0.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
