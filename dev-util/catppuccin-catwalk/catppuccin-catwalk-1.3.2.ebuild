# Copyright 2024 Catppuccin
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="Soothing pastel previews for the high-spirited!"
HOMEPAGE="https://github.com/catppuccin/catwalk"
SRC_URI="https://github.com/catppuccin/catwalk/releases/download/v"${PV}"/catwalk-x86_64-unknown-linux-gnu -> catwalk"
S="${WORKDIR}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	insinto /usr/bin
	doins /var/tmp/portage/dev-util/catppuccin-catwalk-"${PV}"/distdir/catwalk
}
