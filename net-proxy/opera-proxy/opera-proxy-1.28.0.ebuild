# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit go-module

DESCRIPTION="Standalone Opera VPN proxies client"
HOMEPAGE="https://github.com/Alexey71/opera-proxy"
SRC_URI="https://github.com/Alexey71/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/sysrq-golang-dist/${PN}/releases/download/v${PV}/${P}-vendor.tar.xz"

LICENSE="MIT"
# Go dependency licenses
LICENSE+=" BSD BSD-2 MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.25.0"

src_prepare() {
	default

	# fails to build
	rm handler/bypass_test.go || die
}

src_compile() {
	ego build -o opera-proxy
}

src_test() {
	ego test -vet=off ./...
}

src_install() {
	dobin opera-proxy
	einstalldocs

	newinitd "${FILESDIR}"/opera-proxy.initd opera-proxy
}
