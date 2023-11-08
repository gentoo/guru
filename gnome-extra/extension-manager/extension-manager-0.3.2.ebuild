# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Note: This is the last version in which the upstream had not introduced
# dependency on sys-libs/libbacktrace, which has been last-rited in ::gentoo.
#
# ebuilds for newer upstream versions have to use an experimental patch that
# makes the libbacktrace dependency optional; please keep this version for
# reasonable time until the patch has been proven stable.

EAPI=8

inherit gnome2-utils meson xdg

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mjakeman/extension-manager.git"
else
	SRC_URI="https://github.com/mjakeman/extension-manager/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A native tool for browsing, installing, and managing GNOME Shell Extensions"
HOMEPAGE="https://mattjakeman.com/apps/extension-manager"

LICENSE="GPL-3+"
SLOT="0"

BDEPEND="
	dev-libs/glib:2
	dev-util/blueprint-compiler
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="
	dev-libs/glib:2
	dev-libs/json-glib
	gui-libs/gtk:4[introspection]
	gui-libs/libadwaita:1[introspection]
	gui-libs/text-engine
	net-libs/libsoup:3.0
"

DEPEND="
	${RDEPEND}
"

src_configure() {
	local emesonargs=()
	if has live ${PROPERTIES}; then
		# Produce a development build for live ebuild
		emesonargs+=( -Ddevelopment=true )
	fi
	meson_src_configure
}

# Tests are skipped because as of version 0.3.0, the tests only validate
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
# RESTRICT="!test? ( test )"
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
