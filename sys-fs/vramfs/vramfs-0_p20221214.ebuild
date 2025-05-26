# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="829b1f2c259da2eb63ed3d4ddef0eeddb08b99e4"

DESCRIPTION="VRAM based file system for Linux"
HOMEPAGE="https://github.com/Overv/vramfs"
SRC_URI="https://github.com/Overv/vramfs/archive/${COMMIT}/${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

PATCHES=( "${FILESDIR}/${PN}-0-makefile-vars.patch" )

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-cpp/clhpp
	sys-fs/fuse:3
	virtual/opencl
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( README.md )

src_install() {
	dobin bin/vramfs
	einstalldocs
}
