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

BDEPEND="
	dev-libs/glib:2
	dev-util/blueprint-compiler
	virtual/pkgconfig
"

RDEPEND="
	dev-libs/glib:2
	dev-libs/json-glib
	gui-libs/gtk:4[introspection]
	gui-libs/libadwaita:1[introspection]
	net-libs/libsoup:3.0
"

DEPEND="
	${RDEPEND}
"

# Tests are skipped because as of version 0.2.3, the tests only validate
# resource files and do not verify any functionality of the program.  Those
# validations are either already handled by QA checks or not relevant on
# Gentoo.  For more information about the rationale, please refer to:
# https://github.com/gentoo/guru/commit/f896bee213fbb62c70e818c1bf503fee2a41919a#comments
#
# If tests are to be executed in the future because the upstream adds
# functionality tests or for other reasons, and should there be no convenient
# way to skip the validations, the following variable values need to be set:
#
# IUSE="test"
# # 'Validate appstream file' test case requires Internet connection
# PROPERTIES="test_network"
# RESTRICT="test"
# BDEPEND="test? ( dev-libs/appstream-glib dev-util/desktop-file-utils )"
src_test() {
	:
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
