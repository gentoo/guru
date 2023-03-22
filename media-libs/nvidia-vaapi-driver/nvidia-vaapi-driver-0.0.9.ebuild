# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A VA-API implemention using NVIDIA's NVDEC, specifically designed to be used by Firefox"
HOMEPAGE="https://github.com/elFarto/nvidia-vaapi-driver"
SRC_URI="https://github.com/elFarto/nvidia-vaapi-driver/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-drivers/nvidia-drivers
	media-libs/nv-codec-headers
	media-libs/libva"
RDEPEND="x11-drivers/nvidia-drivers
	media-libs/gst-plugins-bad[egl]
	media-libs/libva"
BDEPEND="dev-util/meson"

PATCHES=( "${FILESDIR}/${PN}-0.0.8-install-path.patch" )


pkg_postinst() {
	ewarn "This library requires special configuration! See "
	ewarn "${HOMEPAGE}"
	ewarn "The direct backend is currently required on NVIDIA driver series 525 due to a regression"
	ewarn "See ${HOMEPAGE}/issues/126"
}
