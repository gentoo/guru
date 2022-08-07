# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="data compression library for embedded/real-time systems"
HOMEPAGE="https://github.com/atomicobject/heatshrink"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/atomicobject/${PN}.git"
else
	inherit verify-sig
	SRC_URI="https://github.com/atomicobject/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ISC"
SLOT="0"

PATCHES=(
	"${FILESDIR}/Makefile.patch"
)

src_install() {
	local MY_ED="${ED}/usr"
	mkdir "${MY_ED%/}"{,/bin,/include} || die
	emake PREFIX="${MY_ED%/}/" install
}
