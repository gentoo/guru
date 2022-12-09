# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils

DESCRIPTION="Arachne PNR - free and open-source place and route tool for FPGAs"
HOMEPAGE="https://github.com/cseed/arachne-pnr"
LICENSE="ISC"
if [ ${PV} == "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cseed/arachne-pnr.git"
else
	EGIT_COMMIT="c00a14176e589f5ec4cb3914acc6683c608ac401"
	SRC_URI="https://github.com/cseed/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
fi

SLOT="0"
IUSE=""

RDEPEND="dev-embedded/icestorm"
DEPEND="${RDEPEND}"

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
