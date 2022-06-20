# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
VALA_USE_DEPEND="vapigen"

inherit vala meson udev

MY_PV="v${PV/_p/+git}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="A daemon to provide haptic feedback on events"
HOMEPAGE="https://source.puri.sm/Librem5/feedbackd"
SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/${MY_PV}/${MY_P}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
SLOT="0"
IUSE="+introspection +vala"
REQUIRED_USE="vala? ( introspection )"

DEPEND="
	gnome-base/dconf
	media-libs/gsound
	dev-libs/json-glib
	dev-libs/libgudev:=
"
RDEPEND="${DEPEND}
	dev-libs/feedbackd-device-themes
"
BDEPEND="
	dev-libs/gobject-introspection
	vala? ( $(vala_depend) )
"

src_prepare() {
	default

	use vala && vala_setup
	sed -i 's/-G feedbackd/-G video/g' debian/feedbackd.udev || die
}

src_install() {
	meson_src_install
	udev_newrules "${S}/debian/feedbackd.udev" 90-feedbackd.rules
}
