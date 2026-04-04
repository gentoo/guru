# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Generates Go language bindings of services in protobuf definition files for gRPC"
HOMEPAGE="https://github.com/grpc/grpc-go/tree/master/cmd/protoc-gen-go-grpc"
SRC_URI="
	https://github.com/grpc/grpc-go/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

S="${WORKDIR}/grpc-go-${PV}/cmd/protoc-gen-go-grpc"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build
}

src_install() {
	dobin protoc-gen-go-grpc
}
