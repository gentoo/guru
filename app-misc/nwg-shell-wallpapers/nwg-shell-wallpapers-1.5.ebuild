# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SRC_URI="https://github.com/nwg-piotr/nwg-shell-wallpapers/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

DESCRIPTION="Selection of wallpapers contributed to the nwg-shell project"
HOMEPAGE="https://github.com/nwg-piotr/nwg-shell-wallpapers"
LICENSE="MIT"
SLOT="0"

src_install() {
	insinto /usr/share/backgrounds/nwg-shell
	doins wallpapers/*
}
