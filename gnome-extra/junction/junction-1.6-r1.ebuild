# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

TROLL_COMMIT="8d7c2be66a4bf1cbb2081121997a33662fc19cd0"
DESCRIPTION="Application/browser chooser"
HOMEPAGE="
	https://apps.gnome.org/app/re.sonny.Junction/
	https://github.com/sonnyp/Junction
"
SRC_URI="
	https://github.com/sonnyp/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/sonnyp/troll/archive/${TROLL_COMMIT}.tar.gz -> troll-${P}.tar.gz
"
S="${WORKDIR}/${PN^}-${PV}"

LICENSE="GPL-3+"
KEYWORDS="~amd64"
SLOT="0"

DEPEND="
	dev-libs/gjs
	dev-libs/glib:2
"
RDEPEND="${DEPEND}
	dev-libs/gobject-introspection
	dev-libs/libportal[introspection]
	gui-libs/gtk:4[introspection]
	gui-libs/libadwaita:1[introspection]
	net-libs/libsoup:3.0[introspection]
"
BDEPEND="
	dev-util/blueprint-compiler
	sys-devel/gettext
"

src_unpack() {
	default

	rmdir "${S}"/troll || die
	mv "${WORKDIR}"/troll-${TROLL_COMMIT} "${S}"/troll || die
}

src_configure() {
	local mymesonargs=(
		--datadir=/usr/share
	)

	meson_src_configure
}

# only data files validators, skip them
src_test() {
	:
}
