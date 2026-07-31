# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Fan speed controller for Clevo laptops"
HOMEPAGE="https://github.com/agramian/clevo-fan-control"
EGIT_REPO_URI="https://github.com/agramian/clevo-fan-control.git"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	dev-libs/libayatana-appindicator
	x11-libs/gtk+:3
	dev-libs/glib
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DHOME="${T}/portage-home"
)
cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -rfv "${ED}/var" || die
}
