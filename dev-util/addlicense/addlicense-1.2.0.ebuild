# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A program which ensures source code files have copyright license headers"
HOMEPAGE="https://github.com/google/addlicense"
SRC_URI="
	https://github.com/google/addlicense/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	# This is necessary until the minimum Go language
	# version in `go.mod` is bumped to 1.14 or higher
	GOFLAGS+=" -mod=vendor"
}

src_compile() {
	ego build
}

src_test() {
	ego test -v -buildmode=default -race ./...
}

src_install() {
	dobin ${PN}

	DOCS=( LICENSE README.md )
	default
}
