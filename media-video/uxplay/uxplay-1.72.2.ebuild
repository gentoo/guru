# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="UxPlay"
MY_PV="${PV}"

inherit cmake

DESCRIPTION="AirPlay Unix mirroring server"
HOMEPAGE="https://github.com/FDH2/UxPlay"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/FDH2/${MY_PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/FDH2/${MY_PN}/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${MY_PN}-${MY_PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="+vaapi +X"

RDEPEND="
	app-pda/libplist
	dev-libs/glib:2
	dev-libs/openssl
	media-libs/gstreamer
	media-libs/gst-plugins-bad
	media-libs/gst-plugins-base
	media-libs/gst-plugins-good
	media-plugins/gst-plugins-libav
	vaapi? ( media-plugins/gst-plugins-vaapi )
	net-dns/avahi[mdnsresponder-compat]
	X? ( x11-libs/libX11 )
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	virtual/pkgconfig
"

src_configure() {
	local mycmakeargs=(
		-DNO_X11_DEPS=$(usex X OFF ON)
	)

	cmake_src_configure
}
