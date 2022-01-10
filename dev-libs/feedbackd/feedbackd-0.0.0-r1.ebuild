# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson udev

KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

MY_COMMIT="753fff3e7ae1d0bce4f58cef721e45c50c404786"
MY_THEME_COMMIT="d0ac6ae01b184d65f32a640e02539e807bf2a3bf"

DESCRIPTION="A daemon to provide haptic feedback on events"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd"

SRC_URI="https://source.puri.sm/Librem5/feedbackd/-/archive/${MY_COMMIT}/${MY_COMMIT}.tar.gz -> ${P}-${MY_COMMIT}.tar.gz
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
		virtual/pkgconfig
		vala? ( $(vala_depend) )
"

src_prepare() {
	default
	eapply_user
	use vala && vala_src_prepare
	sed -i 's/-G feedbackd/-G video/g' "${S}/debian/feedbackd.udev"
}

src_install() {
	default
	meson_src_install
	insinto /usr/share/feedbackd/themes
	doins "${WORKDIR}/feedbackd-device-themes-${MY_THEME_COMMIT}/data/"*.json
	udev_newrules "${S}/debian/feedbackd.udev" 90-feedbackd.rules
}
