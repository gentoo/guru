# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

MY_PV=$(ver_cut 1-3)
MY_P="${PN}-${MY_PV}"
DESCRIPTION="A fully-modern text-based browser, rendering to TTY and browsers"

HOMEPAGE="
	https://www.brow.sh
	https://github.com/browsh-org/browsh
"

SRC_URI="
	https://github.com/browsh-org/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/browsh-org/${PN}/releases/download/v${MY_PV}/${MY_P}.xpi
"
SRC_URI+=" https://gentoo.kropotkin.rocks/go-pkgs/${P}-vendor.tar.xz"

S="${WORKDIR}/${P}/interfacer"
LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 CC-BY-3.0 ISC LGPL-2.1 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

BDEPEND="dev-go/go-bindata"
DEPEND="|| ( www-client/firefox:* www-client/firefox-bin:* )"
RDEPEND="${DEPEND}"

src_unpack() {
	go-module_src_unpack
	cp "${DISTDIR}/${MY_P}.xpi" "${S}/src/browsh/${PN}.xpi" || die
}

src_compile() {
	go-bindata \
		-nocompress \
		-pkg browsh \
		-prefix "${S}" \
		-o "${S}/src/browsh/webextension.go" \
		"${S}/src/browsh/${PN}.xpi" || die "bundling web extension failed"
	go build ./cmd/browsh || die
}

src_install() {
	dobin ${PN}
}
