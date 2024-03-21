# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_COMMIT="7d02981d23ecfc279c87ff6c172ba09314940352"

DESCRIPTION="Papirus icon theme for Claws Mail"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/papirus-claws-mail-theme"
SRC_URI="https://github.com/PapirusDevelopmentTeam/papirus-claws-mail-theme/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${PN}-${MY_COMMIT}"
