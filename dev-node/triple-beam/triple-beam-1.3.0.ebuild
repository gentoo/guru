# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Definitions of levels for logging purposes & shareable Symbol constants."
HOMEPAGE="
	https://github.com/winstonjs/triple-beam
	https://www.npmjs.com/package/triple-beam
"
SRC_URI="https://registry.npmjs.org/triple-beam/-/triple-beam-1.3.0.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}