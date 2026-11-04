# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="cc2605e11a08ccd5651a816d28ec4d11f18836c9"

DESCRIPTION="VRAM based file system for Linux"
HOMEPAGE="https://github.com/Overv/vramfs"
SRC_URI="https://github.com/Overv/vramfs/archive/${COMMIT}/${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

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

src_install() {
	dobin bin/vramfs
	einstalldocs
}
