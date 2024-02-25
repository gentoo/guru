EAPI=8

SLOT="0"
LICENSE="GPL-3"

DESCRIPTION="Open Visualization Tool"
HOMEPAGE="https://www.ovito.org"

ICON="logo_rgb-768x737.png"

SRC_URI="
	https://gitlab.com/stuko/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2
	https://www.ovito.org/wp-content/uploads/${ICON}
"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-v${PV}"

inherit cmake desktop

DEPEND="
	dev-qt/qtbase:6[gui]
	dev-qt/qtsvg:6
	sci-libs/hdf5
	dev-libs/boost
	sci-libs/netcdf
	media-video/ffmpeg
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
