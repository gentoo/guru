# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="Missing keepalive http.Agent"
HOMEPAGE="
	https://github.com/node-modules/agentkeepalive
	https://www.npmjs.com/package/agentkeepalive
"
SRC_URI="https://registry.npmjs.org/agentkeepalive/-/agentkeepalive-4.1.3.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
