# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson udev

IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

MY_PV="${PV}+git20210426"
MY_P="${PN}-${MY_PV}"
MY_COMMIT="b45468080eee851da500613ecedd709639b6d769"
MY_THEME_COMMIT="1602d415aed30b1a67c0ff270551230725b8ef92"

DESCRIPTION="A daemon to provide haptic feedback on events"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd"
SRC_URI="
	https://source.puri.sm/Librem5/feedbackd/-/archive/${MY_COMMIT}/${MY_COMMIT}.tar.gz
	https://source.puri.sm/Librem5/feedbackd-device-themes/-/archive/${MY_THEME_COMMIT}/feedbackd-device-themes-${MY_THEME_COMMIT}.tar.gz
"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~arm64"
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
	sed -i 's/-G feedbackd/-G video/g' "${S}"/debian/feedbackd.udev || die
}

src_install() {
	default
	meson_src_install
	insinto /usr/share/feedbackd/themes
	doins "${FILESDIR}"/pine64.pinephone.json
	doins "${FILESDIR}"/purism.librem5.json
	udev_newrules "${S}"/debian/feedbackd.udev 90-feedbackd.rules
}
