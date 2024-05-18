# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake edo

DESCRIPTION="R6RS/R7RS Scheme system."
HOMEPAGE="https://bitbucket.org/ktakashi/sagittarius-scheme"
SRC_URI="https://bitbucket.org/ktakashi/sagittarius-scheme/downloads/${P}.tar.gz"
PATCHES=( "${FILESDIR}/${PN}-compiler-flags.patch" )

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/boehm-gc
	dev-libs/libffi
	dev-libs/openssl
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

src_unpack() {
	default

	# avoid running ldconfig
	edo truncate -s0 "${S}"/cmake/CMakeLists.txt

	edo cd "${S}"/test/tests
	# following tests always fail in sandbox
	edo rm net/http-client.scm net/socket.scm rfc/websocket.scm
	# following tests randomly(?!) fail
	edo rm net/server.scm rfc/oauth2.scm rsa/pkcs/%3a12.scm security/keystore.scm
}
