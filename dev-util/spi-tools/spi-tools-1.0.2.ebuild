# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Simple command line tools to help using Linux spidev devices"
HOMEPAGE="https://github.com/cpb-/spi-tools"
SRC_URI="https://github.com/cpb-/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	default
	eautoreconf
}
