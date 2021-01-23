# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Fill in a range of numbers or letters, optionally passing an increment or step to use, or create a regex-compatible range with options.toRegex"
HOMEPAGE="
	https://github.com/jonschlinkert/fill-range
	https://www.npmjs.com/package/fill-range
"
SRC_URI="https://registry.npmjs.org/fill-range/-/fill-range-7.0.1.tgz -> ${P}.tgz"
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
	local dir="${ED}/usr/$(get_libdir)/node_modules/fill-range"
	mkdir -p "${dir}" || die
	mv package/* "${dir}" || die
}
