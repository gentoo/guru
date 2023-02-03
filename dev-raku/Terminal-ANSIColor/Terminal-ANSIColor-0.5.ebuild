# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

COMMIT="eeb2dadd2cc2b7df34588be7869768213fd9fff4"

DESCRIPTION="Colorize terminal output"
HOMEPAGE="https://github.com/tadzik/Terminal-ANSIColor"
SRC_URI="https://github.com/tadzik/Terminal-ANSIColor/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README"
S="${WORKDIR}/${PN}-${COMMIT}"
