# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Real-time media server for WebRTC"
HOMEPAGE="https://livekit.com/"
SRC_URI="
	https://github.com/livekit/livekit/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://dblsaiko.net/pub/dist/${P}-deps.tar.xz"
LICENSE="Apache-2.0"
LICENSE+=" Apache-2.0 BSD-2 BSD ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.26.0"

src_compile() {
	ego build -o bin/livekit-server ./cmd/server
}

src_install() {
	dobin bin/*
}
