# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Check and get file hashes"
HOMEPAGE="
	https://github.com/ForbesLindesay/sha
	https://www.npmjs.com/package/sha
"
SRC_URI="https://registry.npmjs.org/sha/-/sha-3.0.0.tgz"
LICENSE="|| ( BSD-2 MIT )"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/graceful-fs
"

S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}
