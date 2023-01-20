# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Use nvim as a pager to view manpages, diff, etc with nvim's syntax highlighting."
HOMEPAGE="https://github.com/lucc/nvimpager"

SRC_URI="https://github.com/lucc/nvimpager/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD-2"
SLOT="0"
IUSE=""

# Disable nvimpager from app-editors/neovim
DEPEND="
	app-shells/bash:*
	>=app-editors/neovim-0.4.0[-nvimpager]
"
RDEPEND="${DEPEND}"

# Pandoc is needed to generate manpage (Might make optional)
BDEPEND="
	app-text/pandoc
"

# Skip compile phase, because there is none.
src_compile() {
	true
}

src_install() {
	emake PREFIX="${ED}/usr" install

	# Fix nvimpager's RUNTIME variable
	sed -i "s#${ED}##g" "${ED}/usr/bin/nvimpager" ||
		die "sed failed"
}
