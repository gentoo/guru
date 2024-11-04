EAPI=8
DESCRIPTION="Utility for identifying, reading, writing, verifying and erasing flash chips."
HOMEPAGE="https://flashprog.org/"
SRC_URI="https://github.com/SourceArcade/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND=">=dev-libs/libusb-1.0.26
>=dev-embedded/libjaylink-0.3.1
>=dev-embedded/libftdi-1.5-r7
>=dev-libs/libgpiod-1.6.4
>=sys-apps/pciutils-3.13.0"
