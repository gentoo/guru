# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A user-friendly launcher for Bazel"
HOMEPAGE="https://bazel.build/install/bazelisk"
SRC_URI="https://github.com/bazelbuild/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/ezzieyguywuf/go-ebuild-dependencies/blob/main/deps/${P}-deps-r1.tar.gz?raw=true -> ${P}-deps-r1.tar.gz"

LICENSE="MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	go build || die
}

src_install() {
	dobin ${PN}
}
