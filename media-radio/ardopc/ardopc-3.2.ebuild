# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ARDOP C Modem for digital amateur radio"
HOMEPAGE="https://github.com/g8bpq/ardop"
SRC_URI="https://github.com/g8bpq/ardop/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

DEPEND="dev-libs/hidapi"
RDEPEND="${DEPEND}"

S="${WORKDIR}/ardop-${PV}/ARDOPC"

src_prepare() {
    default_src_prepare

    cd "${WORKDIR}/ardop-${PV}" || die
	eapply -p0 "${FILESDIR}/use-hidapi-functions.patch"
	eapply -p0 "${FILESDIR}/use-hidapi-Makefile.patch"
	eapply -p0 "${FILESDIR}/use-hidapi-LinSerial.patch"
}

src_compile() {
    emake -C "${S}" || die "emake failed"
}

src_install() {
    dobin "${S}/ardopc"
    
    if [[ -f "${WORKDIR}/ardop-${PV}/README.md" ]]; then
        dodoc "${WORKDIR}/ardop-${PV}/README.md"
	elif [[ -f "${WORKDIR}/ardop-${PV}/README" ]]; then
	    dodoc "${WORKDIR}/ardop-${PV}/README"
	fi
}
