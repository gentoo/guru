# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for Phosh, merge this package to install"
HOMEPAGE="https://phosh.mobi/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cups +desktop-portal geolocation iio"

RDEPEND="
	app-alternatives/phosh-keyboard
	dev-libs/feedbackd[daemon]
	gnome-base/gnome-core-libs[cups?]
	>=gui-wm/phoc-${PV}
	media-fonts/cantarell
	>=phosh-base/phosh-mobile-settings-${PV}
	>=phosh-base/phosh-shell-${PV}
	>=phosh-base/phosh-tour-${PV}
	x11-themes/gnome-backgrounds
	x11-themes/sound-theme-freedesktop
	desktop-portal? (
		gui-libs/xdg-desktop-portal-wlr
		sys-apps/xdg-desktop-portal-gtk
	)
	geolocation? ( app-misc/geoclue:2.0 )
	iio? ( gnome-extra/iio-sensor-proxy )
"
