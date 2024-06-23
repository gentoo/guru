# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit vim-plugin git-r3

DESCRIPTION="🌈Rainbow CSV - Vim plugin: Highlight columns in CSV and TSV files and run queries in SQL-like language"
HOMEPAGE="https://github.com/mechatroner/rainbow_csv"
EGIT_REPO_URI="https://github.com/mechatroner/rainbow_csv.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="
app-editors/vim
"

src_install() {
    vim-plugin_src_install
}
