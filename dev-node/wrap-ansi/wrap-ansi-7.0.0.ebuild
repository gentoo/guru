# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Wordwrap a string with ANSI escape codes"
HOMEPAGE="
	https://github.com/chalk/wrap-ansi
	https://www.npmjs.com/package/wrap-ansi
"
SRC_URI="https://registry.npmjs.org/wrap-ansi/-/wrap-ansi-7.0.0.tgz -> ${P}.tgz"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/wrap-ansi"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}