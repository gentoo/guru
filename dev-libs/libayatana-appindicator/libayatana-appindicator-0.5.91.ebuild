# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_USE_DEPEND="vapigen"
CMAKE_MAKEFILE_GENERATOR="emake"

inherit vala

DESCRIPTION="Ayatana Application Indicators (Shared Library)"
HOMEPAGE="https://github.com/AyatanaIndicators/libayatana-appindicator"
SRC_URI="https://github.com/AyatanaIndicators/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

FEATURES="${FEATURES} -sandbox"

RDEPEND="
	dev-libs/libdbusmenu[gtk3] \
	>=dev-libs/libayatana-indicator-0.9.0 \
	"

BDEPEND="
	$(vala_depend)
	dev-util/cmake \
	>=dev-libs/glib-2.37 \
	>=x11-libs/gtk+-3.24 \
	dev-libs/gobject-introspection \
	dev-lang/mono \
	>=dev-dotnet/gtk-sharp-2.99 \
	"
src_prepare() {
	vala_setup
	default
}

src_configure() {
	cmake . -DVALA_COMPILER=/usr/bin/valac-$(vala_best_api_version) -DVAPI_GEN=/usr/bin/vapigen-$(vala_best_api_version) || die
}

src_install() {
	insinto /usr/include/
	doins "${S}/src/app-indicator.h"
	doins "${S}/src/app-indicator-enum-types.h"
	insinto /usr/$(get_libdir)/pkgconfig/
	doins "${S}/src/ayatana-appindicator3-0.1.pc"
	doins "${S}/bindings/mono/ayatana-appindicator3-sharp-0.1.pc"
	insinto /usr/$(get_libdir)/
	doins "${S}/src/libayatana-appindicator3.so.1.0.0"
	dosym libayatana-appindicator3.so.1.0.0 /usr/$(get_libdir)/libayatana-appindicator3.so.1
	dosym libayatana-appindicator3.so.1 /usr/$(get_libdir)/libayatana-appindicator3.so
	insinto /usr/$(get_libdir)/girepository-1.0/
	doins "${S}/src/AyatanaAppIndicator3-0.1.typelib"
	doins "${S}/src/AyatanaAppIndicator3-0.1.typelib"
	insinto /usr/$(get_libdir)/ayatana-appindicator3-sharp-0.1
	doins "${S}/bindings/mono/ayatana-appindicator3-sharp.dll.config"
	doins "${S}/bindings/mono/ayatana-appindicator3-sharp.dll"
	doins "${S}/bindings/mono/policy.0.0.ayatana-appindicator3-sharp.config"
	doins "${S}/bindings/mono/policy.0.0.ayatana-appindicator3-sharp.dll"
	doins "${S}/bindings/mono/policy.0.1.ayatana-appindicator3-sharp.config"
	doins "${S}/bindings/mono/policy.0.1.ayatana-appindicator3-sharp.dll"
	dodir /usr/$(get_libdir)/mono/gac/ayatana-appindicator3-sharp/
	dodir /usr/$(get_libdir)/mono/gac/ayatana-appindicator3-sharp/0.5.91.0__bcae265d1c7ab4c2/
	insinto /usr/$(get_libdir)/mono/gac/ayatana-appindicator3-sharp/0.5.91.0__bcae265d1c7ab4c2/
	doins "${S}/bindings/mono/ayatana-appindicator3-sharp.dll.config"
	doins "${S}/bindings/mono/ayatana-appindicator3-sharp.dll"
	dodir /usr/$(get_libdir)/mono/gac/policy.0.0.ayatana-appindicator3-sharp
	dodir /usr/$(get_libdir)/mono/gac/policy.0.0.ayatana-appindicator3-sharp/0.0.0.0__bcae265d1c7ab4c2/
	insinto /usr/$(get_libdir)/mono/gac/policy.0.0.ayatana-appindicator3-sharp/0.0.0.0__bcae265d1c7ab4c2/
	doins "${S}/bindings/mono/policy.0.0.ayatana-appindicator3-sharp.config"
	doins "${S}/bindings/mono/policy.0.0.ayatana-appindicator3-sharp.dll"
	dodir /usr/$(get_libdir)/mono/ayatana-appindicator3-sharp
	# dosym /usr/$(get_libdir)/mono/gac/ayatana-appindicator3-sharp/0.5.91.0__bcae265d1c7ab4c2/ayatana-appindicator3-sharp.dll /usr/$(get_libdir)/mono/ayatana-appindicator3-sharp/ayatana-appindicator3-sharp.dll
	# dosym /usr/$(get_libdir)/mono/gac/policy.0.0.ayatana-appindicator3-sharp/0.0.0.0__bcae265d1c7ab4c2/policy.0.0.ayatana-appindicator3-sharp.dll /$(get_libdir)/mono/ayatana-appindicator3-sharp/policy.0.0.ayatana-appindicator3-sharp.dll
	dosym ayatana-appindicator3-sharp.dll /usr/$(get_libdir)/mono/ayatana-appindicator3-sharp/ayatana-appindicator3-sharp.dll
	dosym policy.0.0.ayatana-appindicator3-sharp.dll /usr/$(get_libdir)/mono/ayatana-appindicator3-sharp/policy.0.0.ayatana-appindicator3-sharp.dll
	insinto /usr/share/gir-1.0
	doins "${S}/src/AyatanaAppIndicator3-0.1.gir"
	insinto /usr/share/vala/vapi
	doins "${S}/bindings/vala/ayatana-appindicator3-0.1.deps"
	doins "${S}/bindings/vala/ayatana-appindicator3-0.1.vapi"
	insinto /usr/include
	doins "${S}/src/app-indicator.h"
	doins "${S}/src/app-indicator-enum-types.h"

}
