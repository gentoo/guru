# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="C-language implementation of Javascript Object Signing and Encryption"
HOMEPAGE="https://github.com/latchset/jose"
SRC_URI="https://github.com/latchset/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/jansson"
RDEPEND="${DEPEND}
	dev-libs/openssl:=
"
BDEPEND=""
