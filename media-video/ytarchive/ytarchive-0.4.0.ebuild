# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Youtube livestream downloader"
HOMEPAGE="https://github.com/Kethsar/ytarchive"
SRC_URI="
	https://github.com/Kethsar/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://files.asokolov.org/gentoo/${P}-vendor.tar.xz
"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-video/ffmpeg"

src_compile() {
	ego build
}

src_install() {
	dobin ytarchive
	einstalldocs
}
