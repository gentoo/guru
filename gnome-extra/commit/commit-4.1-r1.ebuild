# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

TROLL_COMMIT="e7933a083681d23fce0078b0246fcff244af5ac3"
DESCRIPTION="Commit message editor"
HOMEPAGE="
	https://github.com/sonnyp/Commit
	https://apps.gnome.org/Commit/
"
SRC_URI="
	https://github.com/sonnyp/Commit/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/sonnyp/troll/archive/${TROLL_COMMIT}.tar.gz -> ${P}-troll.gh.tar.gz
"
S="${WORKDIR}/${PN^}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-text/libspelling
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"
DEPEND="${RDEPEND}"

BDEPEND="
	app-alternatives/ninja
	dev-libs/appstream-glib
	dev-libs/gjs
	dev-libs/glib:2=
	dev-util/blueprint-compiler
	dev-util/desktop-file-utils
	sys-devel/gettext
	virtual/pkgconfig
"

PATCHES=(
	# This test only validates upstream .xml file
	"${FILESDIR}/remove-failing-tests.patch"
)

src_unpack() {
	default
	mv "${WORKDIR}"/troll-"${TROLL_COMMIT}"/* "${S}"/troll || die
}

src_install() {
	meson_src_install
	dosym -r /usr/bin/re.sonny.Commit /usr/bin/"${PN}"
	dodir /usr/share/metainfo
	mv "${ED}"/usr/share/appdata/re.sonny.Commit.metainfo.xml "${ED}"/usr/share/metainfo/ || die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
