# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A thin wrapper for Terraform"
HOMEPAGE="https://www.gruntwork.io"
SRC_URI="https://github.com/gruntwork-io/${PN%-bin}/releases/download/v${PV}/terragrunt_linux_amd64 -> ${P}.bin"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-lang/go
"
RDEPEND="${DEPEND}"

src_unpack() {
	mkdir -p -- "${S}"
	cp -- "${DISTDIR}/${A}" "${S}/${PN%-bin}"
}

src_compile() { :; }

src_install() {
	dobin "${S}/${PN%-bin}"
}
