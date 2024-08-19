# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
COMMIT="a3e413489ccdd05431401357bf21690536425012"

inherit toolchain-funcs

SRC_URI="https://github.com/Lekensteyn/dmg2img/archive/${COMMIT}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

DESCRIPTION="Convert Apple disk images to IMG format."
HOMEPAGE="https://github.com/Lekensteyn/dmg2img"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND="
	app-arch/bzip2
	dev-libs/openssl
	sys-libs/zlib
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${ED}" install
}
