# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for Phosh, merge this package to install"
HOMEPAGE="https://phosh.mobi/"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-alternatives/phosh-keyboard
	app-misc/geoclue:2.0
	dev-libs/feedbackd[daemon]
	>=gui-wm/phoc-${PV}
	>=phosh-base/phosh-mobile-settings-${PV}
	>=phosh-base/phosh-shell-${PV}
	>=phosh-base/phosh-tour-${PV}
"
