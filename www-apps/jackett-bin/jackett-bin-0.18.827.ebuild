# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd

DESCRIPTION="API Support for your favorite torrent trackers"
HOMEPAGE="https://github.com/Jackett/Jackett"
SRC_URI="
	amd64? ( https://github.com/Jackett/Jackett/releases/download/v${PV}/Jackett.Binaries.LinuxAMDx64.tar.gz -> ${P}-amd64.tar.gz )
	arm? ( https://github.com/Jackett/Jackett/releases/download/v${PV}/Jackett.Binaries.LinuxARM32.tar.gz -> ${P}-arm.tar.gz )
	arm64? ( https://github.com/Jackett/Jackett/releases/download/v${PV}/Jackett.Binaries.LinuxARM64.tar.gz -> ${P}-arm64.tar.gz )
"

KEYWORDS="~amd64 ~arm ~arm64"
LICENSE="GPL-2"
SLOT="0"
RESTRICT="strip"

RDEPEND="
	acct-user/jackett
	app-crypt/mit-krb5
	dev-libs/icu
	dev-util/lttng-ust
"

QA_PREBUILT="*"
S="${WORKDIR}"/Jackett

src_install() {
	dodir /opt/jackett
	cp -a "${S}"/. "${ED}"/opt/jackett || die
	newinitd "${FILESDIR}"/jackett.initd-r1 jackett
	systemd_dounit "${FILESDIR}"/jackett.service
	doenvd "${FILESDIR}"/99jackett
}
