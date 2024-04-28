# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="R6RS/R7RS Scheme system."
HOMEPAGE="https://bitbucket.org/ktakashi/sagittarius-scheme"
SRC_URI="https://bitbucket.org/ktakashi/sagittarius-scheme/downloads/${P}.tar.gz"

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
	truncate -s0 "${S}"/cmake/CMakeLists.txt

	# following tests always fail in sandbox
	cd "${S}"/test/tests
	rm net/http-client.scm
	rm net/socket.scm
	rm rfc/websocket.scm
}
