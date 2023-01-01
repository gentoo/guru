# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A POSIX *nix fetch script using Nerdfonts"
HOMEPAGE="https://github.com/ThatOneCalculator/NerdFetch"
SRC_URI="https://github.com/ThatOneCalculator/NerdFetch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/NerdFetch-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	dobin "nerdfetch"
	dodoc "README.md"
}
