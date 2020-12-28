# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="ultra fast, simple, secure & standards compliant web I/O"
HOMEPAGE="https://github.com/uNetworking/uWebSockets"
SRC_URI="https://github.com/Jackett/Jackett/releases/download/v${PV}/Jackett.Binaries.LinuxAMDx64.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}"/Jackett

KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"
RESTRICT="strip"

RDEPEND="
	app-crypt/mit-krb5
	dev-libs/icu
	dev-util/lttng-ust
"

QA_PRESTRIPPED="/opt/jackett/*"
QA_PREBUILT="/opt/jackett/*.so"

src_compile(){
	return
}

src_install() {
	dodir /opt/jackett
	cp -a "${S}"/. "${ED}"/opt/jackett || die
	newinitd "${FILESDIR}"/jackett.initd jackett
	doenvd "${FILESDIR}"/99jackett
}
