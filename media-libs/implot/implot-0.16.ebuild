# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson-multilib

MESON_WRAP_VER="1"

DESCRIPTION="Immediate Mode Plotting"
HOMEPAGE="
	https://github.com/epezent/implot/
"

SRC_URI="
	https://github.com/epezent/implot/archive/v${PV}.tar.gz -> implot-${PV}.tar.gz
	https://wrapdb.mesonbuild.com/v2/implot_${PV}-${MESON_WRAP_VER}/get_patch -> implot-${PV}-${MESON_WRAP_VER}-meson-wrap.zip
"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

DEPEND="
	media-libs/imgui
"

BDEPEND="
	virtual/pkgconfig
	app-arch/unzip
"

PATCHES=(
	"${FILESDIR}/${P}-wrapdb-meson-fix.diff"
)

src_unpack() {
	default

	unpack implot-${PV}-${MESON_WRAP_VER}-meson-wrap.zip
}
