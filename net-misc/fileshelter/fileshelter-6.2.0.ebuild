# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake systemd

DESCRIPTION="FileShelter is a “one-click” file sharing web application "
HOMEPAGE="https://fileshelter-demo.poupon.dev https://github.com/epoupon/fileshelter"
SRC_URI="https://github.com/epoupon/fileshelter/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	acct-user/fileshelter
	app-arch/libarchive
	dev-cpp/wt:=
	dev-libs/boost:=
	dev-libs/libconfig[cxx]
"

RDEPEND="${DEPEND}"

DOCS=( INSTALL.md README.md )

PATCHES="
	${FILESDIR}/${PN}-6.2.0-fix-lib-dir.patch
	${FILESDIR}/${PN}-6.2.0-algorithm.patch
	${FILESDIR}/${PN}-6.2.0-hierarchy.patch
"

src_install() {
	cmake_src_install

	systemd_newunit conf/systemd/default.service fileshelter.service
	newinitd "${FILESDIR}/fileshelter.init" fileshelter

	keepdir /var/log/fileshelter
	fowners -R fileshelter:fileshelter /var/log/fileshelter

	mv "${ED}/usr/share/fileshelter/fileshelter.conf" "${ED}/etc/fileshelter.conf" || die

	rm "${ED}/usr/share/fileshelter/default.service" || die

	keepdir /var/lib/fileshelter
	fowners fileshelter:fileshelter /var/lib/fileshelter
}
