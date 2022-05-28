# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Pure-C embeddable compiler backend"
HOMEPAGE="https://c9x.me/compile/"
EGIT_REPO_URI="git://c9x.me/qbe.git"
LICENSE="MIT"
SLOT="0"

src_install() {
	PREFIX=/usr default
}
