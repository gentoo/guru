EAPI=8

DESCRIPTION="Open Visualization Tool"
HOMEPAGE="https://www.ovito.org"

ICON="${PN}_icon.png"
SRC_URI="
	https://gitlab.com/stuko/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2
	https://www.ovito.org/wp-content/uploads/logo_rgb-768x737.png -> ${ICON}
"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64"

inherit cmake desktop

DEPEND="
	dev-libs/boost
	dev-libs/c-blosc
	dev-qt/qtbase:6[gui]
	dev-qt/qtsvg:6
	media-video/ffmpeg
	sci-libs/hdf5
	sci-libs/netcdf
	virtual/opengl
"

src_configure() {
	cmake_src_configure
}

src_install() {
	cmake_src_install

	domenu "${FILESDIR}/ovito.desktop"
	newicon "${DISTDIR}/${ICON}" ovito.png
}
