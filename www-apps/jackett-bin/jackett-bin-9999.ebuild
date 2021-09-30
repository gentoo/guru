# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd unpacker
PROPERTIES+="live"

DESCRIPTION="API Support for your favorite torrent trackers"
HOMEPAGE="https://github.com/Jackett/Jackett"

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

src_unpack() {
	local PKG_BASE_URL="https://github.com/Jackett/Jackett/releases/latest/download/"
	local PKG_NAME="Jackett.Binaries.LinuxSUBSTVAR.tar.gz"
	local PKG_URL
	use amd64 && PKG_NAME="${PKG_NAME/SUBSTVAR/AMDx64}"
	use arm   && PKG_NAME="${PKG_NAME/SUBSTVAR/ARM32}"
	use arm64 && PKG_NAME="${PKG_NAME/SUBSTVAR/ARM64}"
	PKG_URL="${PKG_BASE_URL}${PKG_NAME}"
	einfo "Fetching ${PKG_URL}"
	wget "${PKG_URL}" || die
	unpacker "${PKG_NAME}"
}

src_install() {
	dodir /opt/jackett
	cp -a "${S}"/. "${ED}"/opt/jackett || die
	newinitd "${FILESDIR}"/jackett.initd-r1 jackett
	systemd_dounit "${FILESDIR}"/jackett.service
	doenvd "${FILESDIR}"/99jackett
}
