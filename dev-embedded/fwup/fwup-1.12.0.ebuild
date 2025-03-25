# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Configurable embedded Linux firmware update creator and runner"
HOMEPAGE="https://github.com/fwup-home/fwup"
SRC_URI="https://github.com/fwup-home/fwup/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-arch/libarchive
	app-arch/zip
	dev-libs/confuse
	dev-util/xdelta:3
	sys-fs/dosfstools
	sys-fs/mtools
	sys-fs/squashfs-tools
"

src_prepare() {
	default
	./autogen.sh
}
