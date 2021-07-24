# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson udev

KEYWORDS="~arm ~arm64"

IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

MY_COMMIT="48b4bb97d62fa1917a9e54852f593d3190ef188c"
MY_THEME_COMMIT="516e80e0b00bbd904e64b0c272c40218290fe9f5"

DESCRIPTION="A daemon to provide haptic feedback on events"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd"

SRC_URI="https://source.puri.sm/Librem5/feedbackd/-/archive/${MY_COMMIT}/${MY_COMMIT}.tar.gz
https://source.puri.sm/Librem5/feedbackd-device-themes/-/archive/${MY_THEME_COMMIT}/feedbackd-device-themes-${MY_THEME_COMMIT}.tar.gz
"

S=${WORKDIR}/${PN}-${MY_COMMIT}

LICENSE="LGPL-3"
SLOT="0"

DEPEND="
		gnome-base/dconf
		media-libs/gsound
		dev-libs/json-glib
		dev-libs/libgudev
"
RDEPEND="${DEPEND}"
BDEPEND="
		dev-libs/gobject-introspection
		dev-util/meson
		dev-util/pkgconfig
		vala? ( $(vala_depend) )
"

src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare
	sed -i 's/-G feedbackd/-G video/g' ${S}/debian/feedbackd.udev
}

src_install() {
	default
	meson_src_install
	insinto /usr/share/feedbackd/themes
	doins ${WORKDIR}/feedbackd-device-themes-${MY_THEME_COMMIT}/data/*.json
	udev_newrules ${S}/debian/feedbackd.udev 90-feedbackd.rules
}
