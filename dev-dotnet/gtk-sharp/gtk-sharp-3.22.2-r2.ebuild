# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

MY_PN="GtkSharp"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="gtk bindings for mono"
HOMEPAGE="https://github.com/GLibSharp/GtkSharp"
SRC_URI="https://github.com/GLibSharp/GtkSharp/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm64 ~ppc ~x86"
SLOT="3"
IUSE="+atk +cairo +gdk +gtk +pango"

REQUIRED_USE="
	gdk? ( atk cairo pango )
	gtk? ( atk cairo gdk pango )
	pango? ( cairo )
"

RDEPEND="
	>=dev-libs/glib-2.32
	x11-libs/gtk+:3
"

DEPEND="${RDEPEND}
	>=dev-lang/mono-6.12
	atk? ( app-accessibility/at-spi2-core )
	cairo? ( x11-libs/cairo )
	gdk? ( x11-libs/gdk-pixbuf )
	gtk? ( x11-libs/gtk+:3 )
	pango? ( x11-libs/pango )"

PATCHES=( "${FILESDIR}/01-meson-build-gio.patch" )

src_configure() {
	local emesonargs=(
		$(meson_feature atk)
		$(meson_feature cairo)
		$(meson_feature gdk)
		$(meson_feature gtk)
		$(meson_feature pango)
		-Dinstall=true
	)

	meson_src_configure
}

src_install() {
	meson_src_install
}
