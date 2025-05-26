# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
"

RUST_MIN_VER="1.85.0"

inherit cargo desktop xdg virtualx

DESCRIPTION="App to find duplicates, empty folders and similar images"
HOMEPAGE="https://github.com/qarmin/czkawka"
SRC_URI="
	https://github.com/qarmin/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/70192841/packages/generic/${PN}/${PV}/${P}-crates.tar.xz
"

# questionable license for gtk gui assets
# https://github.com/qarmin/czkawka/issues/1029
LICENSE="MIT gtk? ( CC-BY-4.0 ) "
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 BSD Boost-1.0 ISC
	LGPL-2.1 LGPL-3 MIT MPL-2.0 UoI-NCSA Unicode-3.0 ZLIB
	|| ( GPL-3 )
"

#TODO: krokiet, the new frontend
#https://github.com/qarmin/czkawka/blob/master/krokiet/README.md

SLOT="0"
KEYWORDS="~amd64"
IUSE="gui gtk raw heif"
REQUIRED_USE="
	gui? ( gtk )
"

DEPEND="
	gtk? (
		dev-libs/glib:2
		gui-libs/gtk:4
		x11-libs/cairo
		x11-libs/gdk-pixbuf:2
		x11-libs/pango
	)
	heif? (
		media-libs/libheif:=
	)
	raw? (
		media-libs/libraw
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	virtual/pkgconfig
"

QA_FLAGS_IGNORED=".*"

src_configure() {
	local myfeatures=(
		$(usev heif)
		$(usev raw libraw)
	)
	cargo_src_configure --no-default-features --bin czkawka_cli $(usev gui "--bin czkawka_gui")
}

src_test() {
	virtx cargo_src_test
}

src_install() {
	dobin $(cargo_target_dir)/czkawka_cli

	use gtk && dobin $(cargo_target_dir)/czkawka_gui

	if use gui; then
		doicon data/icons/com.github.qarmin.czkawka.svg
		doicon data/icons/com.github.qarmin.czkawka-symbolic.svg
		domenu data/com.github.qarmin.czkawka.desktop
		insinto /usr/share/metainfo
		doins data/com.github.qarmin.czkawka.metainfo.xml
	fi
}
