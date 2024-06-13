# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

EGIT_REPO_URI="https://github.com/lzfse/lzfse"

DESCRIPTION="LZFSE compression library and command line tool."
HOMEPAGE="https://github.com/lzfse/lzfse"
LICENSE="BSD"
SLOT="0"

src_install() {
	emake INSTALL_PREFIX="${ED}"/usr install
}
