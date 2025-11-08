# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PN="Inter"
DESCRIPTION="Inter font family"
HOMEPAGE="https://rsms.me/inter/"
SRC_URI="https://github.com/rsms/${PN}/releases/download/v${PV}/${MY_PN}-${PV}.zip -> ${P}.zip"

S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos"

FONT_SUFFIX="ttc ttf"
RESTRICT="binchecks strip"

BDEPEND="app-arch/unzip"
