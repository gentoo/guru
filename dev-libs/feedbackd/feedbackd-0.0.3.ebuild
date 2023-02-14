# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
VALA_USE_DEPEND="vapigen"

inherit vala meson

DESCRIPTION="A daemon to provide haptic feedback on events"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd"
SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
SLOT="0"
IUSE="gtk-doc +introspection man test +vala"
REQUIRED_USE="vala? ( introspection )"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/glib:2
	introspection? ( dev-libs/gobject-introspection )
"
RDEPEND="${DEPEND}
	dev-libs/feedbackd-device-themes
"
BDEPEND="
	dev-util/gdbus-codegen
	gtk-doc? ( dev-util/gi-docgen )
	man? ( dev-python/docutils )
	vala? ( $(vala_depend) )
"

src_prepare() {
	default

	use vala && vala_setup
	sed -i 's/-G feedbackd/-G video/g' debian/feedbackd.udev || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature introspection)
		$(meson_use gtk-doc gtk_doc)
		$(meson_use man)
		$(meson_use test tests)
		$(meson_use vala vapi)
		-Ddaemon=false # gmobile is not packaged yet
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	if use gtk-doc; then
		mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
		mv "${ED}"/usr/share/doc/libfeedback-${SLOT} "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}
