# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev systemd

COMMIT="cefcd46502acca9bd396c885df445a712c8c4eff"

DESCRIPTION="Modem scripts for the PinePhone"
HOMEPAGE="https://gitlab.manjaro.org/manjaro-arm/packages/community/phosh/pinephone-modem-scripts"
EGIT_REPO_URI="https://gitlab.manjaro.org/manjaro-arm/packages/community/phosh/pinephone-modem-scripts/-/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
EGIT_BRANCH=eg25-manager

S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"

RDEPEND="
	net-dialup/atinout
	sci-geosciences/gpsd
"

src_install() {
	udev_dorules "${S}"/90-modem-eg25.rules
	systemd_dounit "${S}"/pinephone-modem-scripts.pinephone-modem-setup.service
	dobin "${S}"/pinephone-modem-setup.sh
}
