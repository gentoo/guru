# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="A fork of Terraform that is open-source and community-driven"
HOMEPAGE="https://opentofu.org/"

MY_PV="${PV/_rc/-rc}"
S="${WORKDIR}/${PN}-${MY_PV}"
SRC_URI="https://github.com/opentofu/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/sin-ack/opentofu-vendor/releases/download/v${MY_PV}/opentofu-v${MY_PV}-vendor.tar.gz"

# Main package is MPL-2.0. The rest is obtained with `go-licenses csv ./cmd/tofu'
LICENSE="MPL-2.0 Apache-2.0 BSD-2 ISC MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="dev-go/gox"

RESTRICT="test"

DOCS=( {README,CHANGELOG}.md )

src_compile() {
	export CGO_ENABLED=0
	gox \
		-os=$(go env GOOS) \
		-arch=$(go env GOARCH) \
		-output bin/tofu \
		-verbose \
		./cmd/tofu || die
}

src_install() {
	dobin bin/*
	einstalldocs
}

pkg_postinst() {
	elog "If you would like to install shell completions please run:"
	elog "    tofu -install-autocomplete"
}
