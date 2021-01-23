# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="A tiny wrapper around Node.js streams.Transform (Streams2/3) to avoid explicit subclassing noise"
HOMEPAGE="
	https://github.com/rvagg/through2
	https://www.npmjs.com/package/through2
"
SRC_URI="https://registry.npmjs.org/through2/-/through2-4.0.2.tgz"
LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"
DEPEND="
	net-libs/nodejs
"
RDEPEND="
	${DEPEND}
	dev-node/readable-stream
"
S="${WORKDIR}"

src_install() {
	local dir="${ED}/usr/$(get_libdir)/node_modules/"
	mkdir -p "${dir}" || die
	mv package "${dir}/${PN}" || die
}