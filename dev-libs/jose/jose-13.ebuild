# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="C-language implementation of Javascript Object Signing and Encryption"
HOMEPAGE="https://github.com/latchset/jose"
SRC_URI="https://github.com/latchset/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="
	>=dev-libs/jansson-2.10
	sys-libs/zlib
"
RDEPEND="${DEPEND}
	app-misc/jq
	>=dev-libs/openssl-1.0.2:=
"
BDEPEND="
	virtual/pkgconfig

	doc? ( app-text/asciidoc )
"
