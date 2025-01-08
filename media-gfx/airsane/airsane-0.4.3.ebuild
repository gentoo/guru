# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit cmake

DESCRIPTION="Publish SANE scanners via Apple Airscan/eSCL"

HOMEPAGE="https://github.com/SimulPiscator/AirSane"
SRC_URI="https://github.com/SimulPiscator/AirSane/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

# License of the package.  This must match the name of file(s) in the
# licenses/ directory.  For complex license combination see the developer
# docs on gentoo.org for details.
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-gfx/sane-backends
	media-libs/libpng
	media-libs/libjpeg-turbo
	net-dns/avahi
	virtual/libusb:1"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${P}.tar.gz
	mv "AirSane-${PV}" "${P}" || die
}

src_prepare() {
	cmake_src_prepare
# Upstream condtionally installs config files
	sed	-i "${S}/CMakeLists.txt" \
		-e "s/\(.*\)NOT EXISTS \/etc\/airsane\/.*/\11)/g" \
	|| die
# Gentoo uses the "scanner" group not "saned".
# Also remove 15 seocnd delay hack. Shouldn't be needed anymore:
# https://github.com/SimulPiscator/AirSane/issues/55
	sed	-i "${S}/systemd/airsaned.service.in" \
		-e "s/\(Group=\)saned/\1scanner/" \
		-e "/\/bin\/sleep/d" \
	|| die
}
