# Copyright 1999-2023 Gentoo Authors
#
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson

DESCRIPTION="SeaGate's open source harddrive control utilities"
HOMEPAGE="https://github.com/Seagate/openSeaChest"
SRC_URI="https://github.com/Seagate/openSeaChest/releases/download/v${PV}/SourceCode_With_Submodules.tar.xz -> openSeaChest-v${PV}.tar.xz"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
S="${WORKDIR}/openSeaChest-v${PV}"
