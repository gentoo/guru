# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

MY_PN="vala.vim"
COMMIT="ce569e187bf8f9b506692ef08c10b584595f8e2d"
DESCRIPTION="vim plugin: vala language support"
HOMEPAGE="https://github.com/vala-lang/vala.vim https://wiki.gnome.org/Projects/Vala/Vim"
SRC_URI="https://github.com/vala-lang/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="GPL-3"
KEYWORDS="~amd64"
