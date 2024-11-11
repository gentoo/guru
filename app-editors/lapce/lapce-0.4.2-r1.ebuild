# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit cargo desktop xdg-utils

DESCRIPTION="Lightning-fast and Powerful Code Editor written in Rust "
HOMEPAGE="https://lapce.dev/"
SRC_URI="
	https://github.com/lapce/lapce/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/lapce/lapce/releases/download/v${PV}/vendor.tar.gz -> ${P}-vendor.tar.gz
"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions Artistic-2 BSD BSD-2 Boost-1.0 CC0-1.0 CeCILL-2.1 GPL-2 ISC MIT MPL-2.0 Unicode-DFS-2016 Unlicense ZLIB"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	x11-libs/gtk+:3
	media-libs/fontconfig
	sys-libs/zlib
	x11-libs/libxcb:=
	dev-libs/libgit2:=
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	sys-devel/gcc
	virtual/pkgconfig
"

# rust does not use *FLAGS from make.conf, silence portage warning
QA_FLAGS_IGNORED="usr/bin/.*"

src_unpack() {
	default
	cargo_gen_config
	ln -s "${WORKDIR}/vendor/" "${WORKDIR}/lapce-${PV}/vendor" || die
	sed -i "${ECARGO_HOME}/config.toml" -e '/source.crates-io/d'  || die
	sed -i "${ECARGO_HOME}/config.toml" -e '/replace-with = "gentoo"/d'  || die
	sed -i "${ECARGO_HOME}/config.toml" -e '/local-registry = "\/nonexistent"/d'  || die
	cat "${WORKDIR}/vendor/vendor-config.toml" >> "${ECARGO_HOME}/config.toml" || die
}

src_compile() {
	export RELEASE_TAG_NAME=v"${PV}"
	cargo_src_compile
}

src_install() {
	dobin "$(cargo_target_dir)"/lapce{,-proxy}
	domenu extra/linux/dev.lapce.lapce.desktop
	newicon extra/images/logo.png dev.lapce.lapce.png
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
