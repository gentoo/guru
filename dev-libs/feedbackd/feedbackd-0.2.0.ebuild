# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
VALA_USE_DEPEND="vapigen"

inherit vala meson udev

GMOBILE_COMMIT="d483537aee4778b114ce5d50c4c8a9f8d58337ed"
DESCRIPTION="A daemon to provide haptic feedback on events"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd"
SRC_URI="
	https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2
	https://gitlab.gnome.org/guidog/gmobile/-/archive/${GMOBILE_COMMIT}.tar.bz2 -> gmobile-${GMOBILE_COMMIT}.tar.bz2
"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+daemon gtk-doc +introspection man test +vala"
REQUIRED_USE="vala? ( introspection )"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/glib:2
	daemon? (
		dev-libs/json-glib
		dev-libs/libgudev
		media-libs/gsound
	)
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

	if use daemon; then
		rmdir "${S}/subprojects/gmobile" || die
		mv "${WORKDIR}/gmobile-${GMOBILE_COMMIT}" "${S}/subprojects/gmobile" || die
	fi

	use vala && vala_setup
	sed -i 's/-G feedbackd/-G video/g' debian/feedbackd.udev || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature introspection)
		$(meson_use daemon)
		$(meson_use gtk-doc gtk_doc)
		$(meson_use man)
		$(meson_use test tests)
		$(meson_use vala vapi)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	udev_newrules debian/feedbackd.udev 90-feedbackd

	if use gtk-doc; then
		mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
		mv "${ED}"/usr/share/doc/libfeedback-${SLOT} "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
