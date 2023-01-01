# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

S="${WORKDIR}/NerdFetch-${PV}"

DESCRIPTION="A POSIX *nix fetch script using Nerdfonts"
HOMEPAGE="https://github.com/ThatOneCalculator/NerdFetch"
SRC_URI="https://github.com/ThatOneCalculator/NerdFetch/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_unpack() {
	unpack v${PV}.tar.gz
}

src_install() {
	dobin "nerdfetch"
	dodoc "README.md"
}
