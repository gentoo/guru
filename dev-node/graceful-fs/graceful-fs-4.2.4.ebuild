# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="A drop-in replacement for fs, making various improvements"
HOMEPAGE="https://github.com/isaacs/node-graceful-fs"
SRC_URI="https://registry.npmjs.org/graceful-fs/-/graceful-fs-4.2.4.tgz"
LICENSE="ISC"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/package"

src_install() {
	npm install -g --production --prefix "${ED}/usr" $(npm pack . | tail -1)
}
