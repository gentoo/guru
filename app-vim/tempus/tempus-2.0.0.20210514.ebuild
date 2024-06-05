# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit vim-plugin

COMMIT="b720ee2d4c5588b5a27bb3544d3ded5ee1acab45"
DESCRIPTION="Accessible themes for Vim"
HOMEPAGE="https://protesilaos.com/tempus-themes/"
SRC_URI="https://gitlab.com/protesilaos/${PN}-themes-vim/-/archive/${COMMIT}/${PN}-themes-vim-${COMMIT}.tar.bz2"
S="${WORKDIR}/${PN}-themes-vim-${COMMIT}"

LICENSE="GPL-3"
KEYWORDS="~amd64"

DOCS=( CONTRIBUTING.md README.md )
