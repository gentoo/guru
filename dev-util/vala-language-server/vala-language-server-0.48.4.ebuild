# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Code Intelligence for Vala & Genie"
HOMEPAGE="https://github.com/vala-lang/vala-language-server"
SRC_URI="https://github.com/vala-lang/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug_mem plugins test"
RESTRICT="!test? ( test )"

DEPEND="dev-lang/vala
	dev-util/gnome-builder
	dev-libs/jsonrpc-glib[vala]
	dev-libs/gobject-introspection
	dev-libs/json-glib
	dev-libs/libgee
	dev-libs/glib"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use debug_mem)
		$(meson_use plugins)
		$(meson_use test tests)
	)
	meson_src_configure
}
