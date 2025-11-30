# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A thin wrapper for Terraform"
HOMEPAGE="https://www.gruntwork.io"
SRC_URI="https://github.com/gruntwork-io/${PN%-bin}/releases/download/v${PV}/terragrunt_linux_amd64 -> ${P}.bin"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

QA_FLAGS_IGNORED=".*"

src_unpack() {
	cp "${DISTDIR}/${P}.bin" terragrunt || die
}

src_install() {
	dobin terragrunt
}
