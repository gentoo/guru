# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for Phosh, merge this package to install"
HOMEPAGE="https://phosh.mobi/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"
IUSE="calls cups geolocation iio +screenshot systemd"

# https://salsa.debian.org/DebianOnMobile-team/meta-phosh
RDEPEND="
	>=app-alternatives/phosh-keyboard-2
	dev-libs/feedbackd[daemon]
	gnome-base/gnome-core-libs[cups?]
	gui-libs/xdg-desktop-portal-wlr
	>=gui-wm/phoc-${PV}
	media-fonts/cantarell
	>=phosh-base/phosh-mobile-settings-${PV}
	>=phosh-base/phosh-shell-${PV}
	>=phosh-base/phosh-tour-0.47.0
	>=phosh-base/xdg-desktop-portal-phosh-0.47.0
	sys-apps/xdg-desktop-portal-gtk
	>=x11-themes/phosh-wallpapers-0.42.0
	x11-themes/sound-theme-freedesktop
	calls? ( net-voip/gnome-calls )
	geolocation? ( app-misc/geoclue:2.0 )
	iio? ( gnome-extra/iio-sensor-proxy )
	screenshot? ( gui-apps/slurp )
	systemd? ( sys-apps/systemd )
	!systemd? ( app-admin/openrc-settingsd )
"
