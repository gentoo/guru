# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shell-completion

DESCRIPTION="Precompiled CLI frontend which connects to Bitwarden comapatible servers"
HOMEPAGE="https://github.com/bitwarden/clients/tree/main/apps/cli"

SRC_URI="
	https://github.com/bitwarden/clients/releases/download/cli-v${PV}/bw-linux-${PV}.zip
"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# non-stripped binary is of 99M but works
# stripped  bianry is of 44M but doesnt work
RESTRICT='strip'

RDEPEND="!app-admin/bitwarden-cli"
BDEPEND="app-arch/unzip"
QA_PREBUILT="usr/bin/bw"

src_compile() {
	./bw completion --shell zsh > bw.zsh 2> /dev/null || die
}

src_install() {
	dobin bw
	newzshcomp bw.zsh _bw
}
