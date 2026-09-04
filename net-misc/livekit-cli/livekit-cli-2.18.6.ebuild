# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Command line interface to LiveKit"
HOMEPAGE="https://livekit.com/"
SRC_URI="
	https://github.com/livekit/livekit-cli/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://dblsaiko.net/pub/dist/${P}-deps.tar.xz"
LICENSE="Apache-2.0 BSD BSD-2 CC-BY-SA-4.0 ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="media-libs/portaudio"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lang/go-1.26.3
	virtual/pkgconfig"

src_compile() {
	ego build -tags portaudio_system -o bin/lk ./cmd/lk
}

src_install() {
	dobin bin/*
}
