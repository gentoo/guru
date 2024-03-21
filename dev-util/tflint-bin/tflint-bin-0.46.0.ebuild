# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A Pluggable Terraform Linter"
HOMEPAGE="https://github.com/terraform-linters/tflint"
SRC_URI="https://github.com/terraform-linters/${PN%-bin}/releases/download/v${PV}/tflint_linux_amd64.zip -> ${P}.zip"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
BDEPEND="app-arch/unzip"

S=${WORKDIR}

src_compile() { :; }

src_install() {
	newbin ${PN%-bin} tflint
}
