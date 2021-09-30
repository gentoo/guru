# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit node

DESCRIPTION="Cryptocurrency bike-shed"
HOMEPAGE="
	https://github.com/handshake-org/hsd
	https://www.npmjs.com/package/hsd
"

LICENSE="MIT"
KEYWORDS="~amd64"
RDEPEND="
	${NODEJS_RDEPEND}
	dev-js/bcfg
	dev-js/bcrypto
	dev-js/bdb
	dev-js/bdns
	dev-js/bevent
	dev-js/bfile
	dev-js/bfilter
	dev-js/bheep
	dev-js/binet
	dev-js/blgr
	dev-js/blru
	dev-js/blst
	dev-js/bmutex
	dev-js/bns
	dev-js/bsert
	dev-js/bsock
	dev-js/bsocks
	dev-js/btcp
	dev-js/buffer-map
	dev-js/bufio
	dev-js/bupnp
	dev-js/bval
	dev-js/bweb
	dev-js/goosig
	dev-js/hs-client
	dev-js/n64
	dev-js/urkel
"

src_install() {
	node_src_install
	# binaries already provided by hs-client
	# https://github.com/handshake-org/hsd/issues/638
	rm "${ED}"/usr/bin/hs{d,w}-cli || die
}
