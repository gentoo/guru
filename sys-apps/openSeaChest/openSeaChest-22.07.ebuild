# Copyright 1999-2023 Gentoo Authors
#
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson

DESCRIPTION="SeaGate's open source harddrive control utilities"
HOMEPAGE="https://github.com/Seagate/openSeaChest"
SRC_URI="
https://github.com/Seagate/openSeaChest/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
https://api.github.com/repos/Seagate/opensea-common/tarball/a2155bb5d1f45e50cc2e0158ed183d15e12de6bd -> opensea-common-a2155bb5d1f45e50cc2e0158ed183d15e12de6bd.tar.gz
https://api.github.com/repos/Seagate/opensea-operations/tarball/f9eab78b3cc349a74a1878b484ca27812506357b -> opensea-operations-f9eab78b3cc349a74a1878b484ca27812506357b.tar.gz
https://api.github.com/repos/Seagate/opensea-transport/tarball/f09d599a992e4e12e2537e9e5592c8bdf799dc0a -> opensea-transport-f09d599a992e4e12e2537e9e5592c8bdf799dc0a.tar.gz
https://api.github.com/repos/Seagate/wingetopt/tarball/a8c80ade25449464bc847d65420f41eb5262ff62 -> wingetopt-a8c80ade25449464bc847d65420f41eb5262ff62.tar.gz
"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""
IDEPEND=""

src_prepare() {
	default

	# Move over submodules, because the upstream tar doesn't have them.
	rmdir "${S}"/'subprojects/opensea-common' || die
	mv "${WORKDIR}"/'Seagate-opensea-common-a2155bb' "${S}"/'subprojects/opensea-common' || die
	rmdir "${S}"/'subprojects/opensea-operations' || die
	mv "${WORKDIR}"/'Seagate-opensea-operations-f9eab78' "${S}"/'subprojects/opensea-operations' || die
	rmdir "${S}"/'subprojects/opensea-transport' || die
	mv "${WORKDIR}"/'Seagate-opensea-transport-f09d599' "${S}"/'subprojects/opensea-transport' || die
	rmdir "${S}"/'subprojects/wingetopt' || die
	mv "${WORKDIR}"/'Seagate-wingetopt-a8c80ad' "${S}"/'subprojects/wingetopt' || die
}

src_configure() {
	meson_src_configure
}
