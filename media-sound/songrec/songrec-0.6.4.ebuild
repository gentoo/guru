# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

RUST_MIN_VER="1.87.0"

inherit cargo desktop xdg

DESCRIPTION="An open-source Shazam client for Linux, written in Rust."
HOMEPAGE="https://github.com/marin-m/SongRec"
SRC_URI="
	${CARGO_CRATE_URIS}
	https://github.com/marin-m/SongRec/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/setotau/gentoo-crate-tarballs/releases/download/${P}/${P}-crates.tar.xz
"

S="${WORKDIR}/SongRec-${PV}"
# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="GPL-3+"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD GPL-3+ ISC MIT
	MPL-2.0 Unicode-3.0 Unlicense ZLIB
"
SLOT="0"
KEYWORDS="~amd64"
DEPEND="
	gui-libs/gtk
	gui-libs/libadwaita
	media-libs/alsa-lib
	media-video/ffmpeg
	dev-libs/openssl
	media-libs/libpulse
"

src_install() {
	cargo_src_install
	domenu packaging/rootfs/usr/share/applications/re.fossplant.songrec.desktop
	doicon -s scalable packaging/rootfs/usr/share/icons/hicolor/scalable/apps/re.fossplant.songrec.svg
	insinto /usr/share/metainfo
	doins packaging/rootfs/usr/share/metainfo/re.fossplant.songrec.metainfo.xml
	insinto /usr/share/
	doins -r translations/locale
}
