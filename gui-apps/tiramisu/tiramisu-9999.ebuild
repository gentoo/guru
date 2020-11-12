# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ "${PV}" == 9999 ]]
then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Sweets/tiramisu"
else
	COMMIT=8eb946dae0e2f98d3850d89e1bb535640e8c3266
	SRC_URI="https://github.com/Sweets/tiramisu/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/${PN}-${COMMIT}
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

DESCRIPTION="minimalistic desktop notifications provider"
HOMEPAGE="https://github.com/Sweets/tiramisu"

LICENSE="MIT"
SLOT="0"

src_install() {
	emake DESTDIR="${ED}" PREFIX=/usr install
}
