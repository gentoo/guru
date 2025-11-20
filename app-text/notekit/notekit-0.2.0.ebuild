# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Write your notes in instantly-formatted Markdown and
add hand-drawn notes by mouse, touchscreen or digitiser."
HOMEPAGE="https://github.com/blackhole89/notekit/"
SRC_URI="https://github.com/blackhole89/notekit/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-cpp/gtkmm:3.0
	dev-cpp/gtksourceviewmm:3.0
	sys-libs/zlib
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

