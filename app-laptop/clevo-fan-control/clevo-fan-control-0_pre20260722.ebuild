# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Fan speed controller for Clevo laptops"
HOMEPAGE="https://github.com/agramian/clevo-fan-control"
EGIT_REPO_URI="https://github.com/agramian/clevo-fan-control.git"

GIT_COMMIT="76465b0ff86b86b1417a8956a49677c684873af1"
SRC_URI="https://github.com/agramian/clevo-fan-control/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${GIT_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

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
