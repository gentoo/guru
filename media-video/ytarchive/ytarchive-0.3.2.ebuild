# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Youtube livestream downloader"
HOMEPAGE="https://github.com/Kethsar/ytarchive"
SRC_URI="https://github.com/Kethsar/ytarchive/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://files.asokolov.org/gentoo/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-video/ffmpeg"

src_compile() {
	go build
}

src_install() {
	default
	dobin ytarchive
}
