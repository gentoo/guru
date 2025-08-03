# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Google Protocol Protobufs RPC for Go"
HOMEPAGE="https://github.com/chai2010/protorpc"
SRC_URI="
	https://github.com/chai2010/protorpc/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build -C protoc-gen-protorpc
}

src_install() {
	dobin protoc-gen-protorpc/protoc-gen-protorpc
}
