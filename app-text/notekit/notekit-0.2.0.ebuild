# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Write your notes in instantly-formatted Markdown"
HOMEPAGE="https://github.com/blackhole89/notekit/"
SRC_URI="https://github.com/blackhole89/notekit/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-cpp/gtkmm:3.0
	dev-cpp/gtksourceviewmm:3.0
	virtual/zlib
	media-libs/fontconfig
	dev-libs/jsoncpp
	dev-libs/tinyxml2
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/meson
	dev-build/ninja
"

src_configure() {
	local emesonargs=(
		"-Dclatexmath=false"
	)
	meson_src_configure
}
