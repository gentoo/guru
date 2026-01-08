# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A Git credential helper that securely authenticates using OAuth"
HOMEPAGE="https://github.com/hickford/git-credential-oauth"
SRC_URI="https://github.com/hickford/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
			https://github.com/setotau/go-vendor-tarballs/releases/download/${P}/${P}-vendor.tar.xz"

LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build
}

src_install() {
	dobin git-credential-oauth
	doman git-credential-oauth.1
	default
}
