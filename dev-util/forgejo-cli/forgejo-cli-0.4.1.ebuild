# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=' '

inherit cargo

DESCRIPTION="CLI application for interacting with Forgejo"
HOMEPAGE="https://codeberg.org/forgejo-contrib/forgejo-cli"
SRC_URI="
	https://codeberg.org/forgejo-contrib/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.xz
	https://codeberg.org/ceres-sees-all/guru-distfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz
"

S="${WORKDIR}/${PN}"

LICENCE="MIT"
#Crate Licenses
LICENSE+=" BSD-2 BSD Unicode-3.0 Apache-2.0 ISC MPL-2.0 ZLIB "
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="mirror"

ECARGO_VENDOR="${WORKDIR}/vendor"
