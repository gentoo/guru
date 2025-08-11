# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo gnome2-utils meson xdg

DESCRIPTION="Identify songs in seconds"
HOMEPAGE="https://github.com/SeaDve/Mousai"
SRC_URI="
	https://github.com/SeaDve/Mousai/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

S="${WORKDIR}/Mousai-${PV}"

LICENSE="Apache-2.0 BSD GPL-3+ MIT MPL-2.0 Unicode-DFS-2016"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/glib:2
	gui-libs/gtk:4
	gui-libs/libadwaita:1
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/gstreamer:1.0
	net-libs/libsoup:3.0
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/appstream
	dev-libs/glib:2
	dev-util/desktop-file-utils
	dev-util/gtk-update-icon-cache
	sys-devel/gettext

	debug? ( dev-vcs/git )
	test? ( dev-vcs/git )
"

PATCHES=(
	"${FILESDIR}/${PN}-0.7.8-remove-the-cargo-clippy-test.patch"
	"${FILESDIR}/${PN}-0.7.8-skip-failing-tests.patch"
)

src_configure() {
	local profile="default"
	(use debug || use test) && profile="development"

	local emesonargs=(
		-Dprofile="$profile"
	)
	meson_src_configure

	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
