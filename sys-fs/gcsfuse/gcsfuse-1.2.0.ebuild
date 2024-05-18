# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A user-space file system for interacting with Google Cloud Storage"
HOMEPAGE="https://github.com/GoogleCloudPlatform/gcsfuse"
SRC_URI="https://github.com/GoogleCloudPlatform/gcsfuse/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://gentoo.kropotkin.rocks/go-pkgs/${P}-vendor.tar.xz"

RDEPEND="sys-fs/fuse"
BDEPEND=">=dev-lang/go-1.21.0"

# generated using dev-go/golicense
LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build -ldflags "-X main.gcsfuseVersion=${PV}" -v -x -work -o "${PN}" || die "build failed"
}

src_install() {
	einstalldocs
	dodoc -r docs
	dobin gcsfuse
}
