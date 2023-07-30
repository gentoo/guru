# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://codeberg.org/dnkl/wbg.git"
	inherit git-r3
else
	SRC_URI="https://codeberg.org/dnkl/wbg/archive/${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
fi

DESCRIPTION="Super simple wallpaper application"
HOMEPAGE="https://codeberg.org/dnkl/wbg"

LICENSE="MIT"
SLOT="0"
IUSE="png jpeg webp"

REQUIRED_USE="|| ( png jpeg webp )"

DEPEND="
	x11-libs/pixman
	dev-libs/wayland
"
RDEPEND="
	${DEPEND}
	png? ( media-libs/libpng:= )
	jpeg? ( media-libs/libjpeg-turbo:= )
	webp? ( media-libs/libwebp:= )
"
BDEPEND="
	dev-libs/tllist
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		$(meson_feature png)
		$(meson_feature jpeg)
		$(meson_feature webp)
	)

	meson_src_configure
}
