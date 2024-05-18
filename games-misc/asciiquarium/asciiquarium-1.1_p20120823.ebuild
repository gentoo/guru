# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="8bdb7d441a36a5a9f64b853317a66f9d4a82f08f"
DESCRIPTION="Asciiquarium is an aquarium/sea animation in ASCII art"
HOMEPAGE="
	https://robobunny.com/projects/asciiquarium/html/
	https://github.com/cmatsuoka/asciiquarium
"
SRC_URI="https://github.com/cmatsuoka/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Term-Animation"
RDEPEND="${DEPEND}"

src_install() {
	dobin asciiquarium
	einstalldocs
}
