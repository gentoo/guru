# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Fast deep equal"
HOMEPAGE="
	https://github.com/epoberezkin/fast-deep-equal
	https://www.npmjs.com/package/fast-deep-equal
"
SRC_URI="https://registry.npmjs.org/fast-deep-equal/-/fast-deep-equal-3.1.3.tgz -> ${P}.tgz"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/fast-deep-equal"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}