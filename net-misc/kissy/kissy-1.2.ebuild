# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Kissing Interface for Sapphic Smooching over ttY"
HOMEPAGE="https://codeberg.org/Magdalunaa/kissy"

SRC_URI="https://codeberg.org/Magdalunaa/kissy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="net-misc/openssh"
DEPEND="${RDEPEND}"
