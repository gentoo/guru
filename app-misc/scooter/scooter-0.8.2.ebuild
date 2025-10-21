# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="Interactive find-and-replace in the terminal"
HOMEPAGE="https://github.com/thomasschafer/scooter"
SRC_URI="
	https://github.com/thomasschafer/scooter/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://gitlab.com/api/v4/projects/69517529/packages/generic/${PN}/${PV}/${P}-deps.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	cargo_src_install --path scooter
	dodoc README.md
}
