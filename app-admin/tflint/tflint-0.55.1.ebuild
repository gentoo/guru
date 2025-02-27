# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Terraform linter"
HOMEPAGE="https://github.com/terraform-linters/tflint"
SRC_URI="https://github.com/terraform-linters/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/dmdutra/gentoo-distfiles/raw/refs/heads/main/${PN}-v${PV}-vendor.tar.xz"

LICENSE="Apache-2.0 BSD BSD-2 MPL-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -v -x -o ${PN}
}

src_install() {
	dobin tflint/${PN}
}
