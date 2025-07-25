# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit vim-plugin

DESCRIPTION="A vim plugin for CSV and TSV highlighting and running queries"
HOMEPAGE="https://github.com/mechatroner/rainbow_csv"

EGIT_COMMIT="3dbbfd7d17536aebfb80f571255548495574c32b"
MY_P="${PN}-${EGIT_COMMIT}"
SRC_URI="https://github.com/mechatroner/rainbow_csv/archive/${EGIT_COMMIT}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	app-editors/vim
"

src_install() {
	vim-plugin_src_install
}
