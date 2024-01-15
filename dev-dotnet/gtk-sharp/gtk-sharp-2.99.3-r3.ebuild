# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit dotnet autotools

SLOT="3"
DESCRIPTION="gtk bindings for mono"
LICENSE="GPL-2"
HOMEPAGE="https://www.mono-project.com/docs/gui/gtksharp/"
KEYWORDS="~amd64 ~ppc ~x86"
SRC_URI="https://github.com/mono/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
IUSE="debug"
PATCHES=( "${FILESDIR}/${P}-fix-build.patch" )

RESTRICT="test"

RDEPEND="
	>=dev-lang/mono-3.0
	x11-libs/pango
	>=dev-libs/glib-2.31
	dev-libs/atk
	x11-libs/gtk+:3
	gnome-base/libglade
	dev-perl/XML-LibXML
	!dev-dotnet/gtk-sharp-gapi
	!dev-dotnet/gtk-sharp-docs
	!dev-dotnet/gtk-dotnet-sharp
	!dev-dotnet/gdk-sharp
	!dev-dotnet/glib-sharp
	!dev-dotnet/glade-sharp
	!dev-dotnet/pango-sharp
	!dev-dotnet/atk-sharp"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-build/automake:1.11"

src_prepare() {
	base_src_prepare
	eautoreconf
	eapply "${FILESDIR}/${P}-fix-build.patch"
	eapply_user
}

src_configure() {
	econf	CSC=/usr/bin/mcs
		--disable-static \
		--disable-dependency-tracking \
		--disable-maintainer-mode \
		$(use_enable debug)
}

src_compile() {
	emake CSC=/usr/bin/mcs
}

src_install() {
	default
	dotnet_multilib_comply
	sed -i "s/\\r//g" "${D}"/usr/bin/* || die "sed failed"
	dosym ../lib64/gapi-3.0 /usr/lib/gapi-3.0
}
