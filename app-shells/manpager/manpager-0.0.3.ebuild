# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="colorize man pages"
HOMEPAGE="https://github.com/Freed-Wu/manpager"

SRC_URI="
	$HOMEPAGE/archive/${PV}.tar.gz -> $P.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	sys-apps/bat
	app-text/ansifilter
"

src_prepare() {
	default
	sed -i "s=/usr=$EPREFIX/usr=g" "bin/$PN"
}

src_install() {
	dobin "bin/$PN"
	echo "MANPAGER=manpager" | newenvd - 00manpager
}
