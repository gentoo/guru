# Copyright 2024 Brayan M. Salazar <this.brayan@proton.me>
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Utility to write Portage config files in an easy manner."
HOMEPAGE="https://github.com/brookiestein/portagecfg"
SRC_URI="https://github.com/brookiestein/portagecfg/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
dev-qt/qtbase:6
dev-qt/linguist-tools:5
"
RDEPEND="${DEPEND}"
BDEPEND=">=dev-build/cmake-3.28"
