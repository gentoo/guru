# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="Debian cryptsetup-scripts with patches for service usage"
HOMEPAGE="https://codeberg.org/gentoo-dinit/cryptsetup"
SRC_URI="https://codeberg.org/gentoo-dinit/cryptsetup/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cryptsetup"
LICENSE="GPL-2+"
SLOT=0
KEYWORDS="~amd64"

RDEPEND="sys-fs/cryptsetup"
DEPEND="${RDEPEND}"
