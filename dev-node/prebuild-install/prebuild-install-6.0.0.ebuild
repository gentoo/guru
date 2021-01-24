# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit node-guru

DESCRIPTION="A command line tool to easily install prebuilt binaries for multiple version of node/iojs on a specific platform"
HOMEPAGE="
	https://github.com/prebuild/prebuild-install
	https://www.npmjs.com/package/prebuild-install
"
SRC_URI="https://registry.npmjs.org/prebuild-install/-/prebuild-install-6.0.0.tgz -> ${P}.tgz"
LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${DEPEND}
"
