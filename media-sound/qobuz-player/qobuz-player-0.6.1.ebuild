# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=""
declare -A GIT_CRATES=(
	[mpris-server]='https://github.com/SeaDve/mpris-server;f8b3f74e93910fffd0c93df687e05cf954dcdeba;mpris-server-%commit%'
)

RUST_MIN_VER="1.88.0"

inherit cargo

DESCRIPTION="Tui, web and rfid player for Qobuz"
HOMEPAGE="https://github.com/SofusA/qobuz-player"
SRC_URI="https://github.com/SofusA/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/gentoo-crate-dist/${PN}/releases/download/v${PV}/${P}-crates.tar.xz"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD CDLA-Permissive-2.0 ISC MIT MPL-2.0 UoI-NCSA
	Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-db/sqlite:3=
	media-libs/alsa-lib
	sys-apps/dbus
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	# high magic to allow system-libs
	export LIBSQLITE3_SYS_USE_PKG_CONFIG=1
	default
}

src_install() {
	cargo_src_install --path qobuz-player-cli

	local DOCS=(
		README.md
	)
	einstalldocs
}
