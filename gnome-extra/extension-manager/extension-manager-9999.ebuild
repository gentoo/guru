# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mjakeman/extension-manager.git"
else
	SRC_URI="https://github.com/mjakeman/extension-manager/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A native tool for browsing and installing GNOME Shell Extensions"
HOMEPAGE="https://github.com/mjakeman/extension-manager"

LICENSE="GPL-3+"
SLOT="0"

IUSE="test"
# 'Validate appstream file' test case requires Internet connection
PROPERTIES="test_network"
RESTRICT="test"

BDEPEND="
	dev-libs/glib:2
	dev-util/blueprint-compiler
	virtual/pkgconfig
	test? (
		dev-libs/appstream-glib
		dev-util/desktop-file-utils
	)
"

DEPEND="
	dev-libs/glib:2
	dev-libs/json-glib
	gui-libs/gtk:4[introspection]
	gui-libs/libadwaita:1[introspection]
	net-libs/libsoup:3.0
"

RDEPEND="
	${DEPEND}
"

src_configure() {
	local emesonargs=()
	if has live ${PROPERTIES}; then
		# Produce a development build for live ebuild
		emesonargs+=( -Ddevelopment=true )
	fi
	meson_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
