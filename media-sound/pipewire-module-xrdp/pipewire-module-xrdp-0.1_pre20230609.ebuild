# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg

COMMIT="e9c6c05dd4327fca43d8861535c1f75c9b258aef"
DESCRIPTION="PipeWire module which enables xrdp to use audio redirection"
HOMEPAGE="https://github.com/neutrinolabs/pipewire-module-xrdp"
SRC_URI="https://github.com/neutrinolabs/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

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
