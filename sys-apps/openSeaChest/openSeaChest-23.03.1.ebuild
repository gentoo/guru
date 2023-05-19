# Copyright 1999-2023 Gentoo Authors
#
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson

DESCRIPTION="SeaGate's open source harddrive control utilities"
HOMEPAGE="https://github.com/Seagate/openSeaChest"
SRC_URI="https://github.com/Seagate/openSeaChest/releases/download/v${PV}/SourceCode_With_Submodules.tar.xz"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_unpack() {
	default

	# upstream decompresses to openSeaChest-vXX.YY. We need openSeaChest-XX.YY
	# without the 'v'.
	# ... for 23.03.1 they still made the source extract to 23.03, so I guess
	# we need to just put the version number here literally instead of using PV
	mv "${WORKDIR}/openSeaChest-v23.03" "${S}"
}
