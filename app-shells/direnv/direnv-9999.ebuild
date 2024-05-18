# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/direnv/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Environment variable manager for shell"
HOMEPAGE="https://github.com/direnv/direnv"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # fails

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	emake DESTDIR="${D}" PREFIX="/usr" install
}
