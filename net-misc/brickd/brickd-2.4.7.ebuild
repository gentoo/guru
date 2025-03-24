# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8
DESCRIPTION="Network Daemon bridging API bindings to Tinkerforge hardware bricks"
HOMEPAGE="https://www.tinkerforge.com/en/doc/Software/Brickd.html https://github.com/Tinkerforge/brickd https://github.com/Tinkerforge/daemonlib"
SRC_URI="
	https://github.com/Tinkerforge/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/Tinkerforge/daemonlib/archive/refs/tags/${P}.tar.gz -> daemonlib-${P}.tar.gz"
S="${WORKDIR}/${P}/src/${PN}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="
	>=dev-libs/libusb-1.0.27
	>=dev-libs/libgpiod-1.6.4"
DEPEND="${RDEPEND}"
BDEPEND=">=virtual/pkgconfig-3
	>=dev-build/make-4.4.1
	>=sys-devel/gcc-14.2.1"
src_configure() {
	# source code of daemonlib package must be linked into brickd sources
	# reference: https://github.com/Tinkerforge/brickd
	ln -s "${WORKDIR}/daemonlib-${P}" "${WORKDIR}/${P}/src/daemonlib" || die
}
src_compile() {
	emake
}
