# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit prefix

DESCRIPTION="A POSIX *nix fetch script using Nerdfonts"
HOMEPAGE="https://github.com/ThatOneCalculator/NerdFetch"
SRC_URI="https://github.com/ThatOneCalculator/NerdFetch/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/NerdFetch-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="app-portage/portage-utils"

src_prepare() {
	default
	hprefixify nerdfetch
}

src_install() {
	dobin "nerdfetch"
	dodoc "README.md"
}
