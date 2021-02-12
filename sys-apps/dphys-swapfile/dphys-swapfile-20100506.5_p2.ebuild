# Copyright 1999-2020 Gentoo Authors
# # Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Provides Using a Swap File instead of a Partition"
HOMEPAGE="http://neil.franklin.ch/Projects/dphys-swapfile/"
BASE_URI="https://archive.raspberrypi.org/debian/pool/main/d/dphys-swapfile"
SRC_URI="${BASE_URI}/${PN}_$(ver_cut 1).orig.tar.gz
         ${BASE_URI}/${PN}_$(ver_cut 1)-$(ver_cut 2)+rpt$(ver_cut 4).debian.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86 ~amd64 ~arm ~arm64 ~x86"

S="${WORKDIR}/${PN}"

src_prepare() {
	default
	local patchdir="${WORKDIR}/debian/patches/"
	while IFS= read -r patch; do
		eapply -p1 "${patchdir}/${patch}"
	done < "${patchdir}"/series
}


src_install() {
	dosbin dphys-swapfile
	dodoc Logfile README
	doman dphys-swapfile.8
	doinitd "${FILESDIR}"/dphys-swapfile
	insinto /etc
	newins dphys-swapfile.example dphys-swapfile
}

pkg_postinst() {
	einfo "Installation of dphys-swapfile is complete"
	einfo "Example config file is /etc/dphys-swapfile.example"
	einfo "Copy/move to /etc/dphys-swapfile and adjust to Overide Defualts "
	elog "  To start dphys-swapfile on boot, please type:"
	elog "    rc-update -v add dphys-swapfile default"
}
