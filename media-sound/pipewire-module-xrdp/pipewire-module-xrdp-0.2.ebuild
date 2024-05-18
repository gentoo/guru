# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg

DESCRIPTION="PipeWire module which enables xrdp to use audio redirection"
HOMEPAGE="https://github.com/neutrinolabs/pipewire-module-xrdp"
SRC_URI="https://github.com/neutrinolabs/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-video/pipewire:="
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}
