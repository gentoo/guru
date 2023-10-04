# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="Next-generation arduino command line tool"
HOMEPAGE="https://arduino.github.io/arduino-cli/latest/"

SRC_URI="
	https://github.com/arduino/arduino-cli/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://pkg.artemis.sh/gentoo/pkg-deps/dev-embedded/arduino-cli/${P}-vendor.tar.xz
"

LICENSE="Apache-2.0 BSD BSD-2 GPL-2 GPL-3 LGPL-3 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_compile() {
	ego build -tags xversion \
		-ldflags "-X github.com/arduino/arduino-cli/version.versionString=${PV}"
}

src_install() {
	dobin arduino-cli
}
