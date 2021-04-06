# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="disable the C6 state upon system boot, preventing Ryzen freezes"
HOMEPAGE="https://github.com/jfredrickson/disable-c6"
COMMIT=82765d490290a99ba18282e187e9de3d7c11dd49
SRC_URI="https://github.com/jfredrickson/disable-c6/archive/${COMMIT}.tar.gz -> disable-c6-${COMMIT}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RDEPEND="sys-power/ZenStates-Linux"
DOCS=( ACKNOWLEDGMENTS README.md )
PATCHES=( "${FILESDIR}/fix-path.patch" )
S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	einstalldocs
	doinitd "${FILESDIR}/disable-c6"
	systemd_newunit "disable-c6.service.template" "disable-c6-service"
}
