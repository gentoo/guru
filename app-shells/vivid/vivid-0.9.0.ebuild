# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4

EAPI=8

CRATES=" "

inherit cargo

DESCRIPTION="A themeable LS_COLORS generator with a rich filetype datebase"
HOMEPAGE="https://github.com/sharkdp/vivid"
SRC_URI="https://github.com/sharkdp/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/ingenarel/guru-depfiles/releases/download/${P}-deps.tar.xz/${P}-deps.tar.xz"
ECARGO_VENDOR="${WORKDIR}/vendor"

LICENSE="LGPL-3+ MIT"
SLOT="0"
KEYWORDS="~amd64"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_install() {
	cargo_src_install
	dodoc CHANGELOG.md README.md

	insinto /usr/share/vivid
	doins config/filetypes.yml

	insinto /usr/share/vivid/themes
	doins themes/*.yml
}
