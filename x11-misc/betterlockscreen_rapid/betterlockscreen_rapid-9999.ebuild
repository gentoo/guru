# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit git-r3

DESCRIPTION="A rapid and good-looking screen locker"
HOMEPAGE="https://github.com/oakszyjrnrdy/betterlockscreen_rapid"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
	x11-misc/i3lock-color
	x11-misc/i3lock-fancy-rapid
"

src_install() {
	dobin "${PN}"
	insinto /etc
	doins "${PN}.conf"
}
