# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="split a Text Stream into a Line Stream"
HOMEPAGE="
	https://github.com/dominictarr/split
	https://www.npmjs.com/package/split
"
SRC_URI="https://registry.npmjs.org/split/-/split-1.0.1.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/through
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}
