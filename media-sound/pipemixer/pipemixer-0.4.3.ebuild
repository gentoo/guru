# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="TUI volume control app for pipewire"
HOMEPAGE="https://github.com/heather7283/pipemixer"

if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/heather7283/${PN}.git"
else
	SRC_URI="https://github.com/heather7283/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="
	media-video/pipewire
	dev-libs/inih
	sys-libs/ncurses
"
DEPEND="${RDEPEND}"
BDEPEND="dev-build/meson"

src_configure() {
	meson_src_configure
}

pkg_postinst() {
	elog "Run 'pipemixer' to start the TUI volume control."
}
