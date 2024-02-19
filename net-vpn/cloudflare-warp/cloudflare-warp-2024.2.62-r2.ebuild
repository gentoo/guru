# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker systemd xdg desktop

DESCRIPTION="Cloudflare Warp Client"
HOMEPAGE="https://1.1.1.1"
SRC_URI="https://pkg.cloudflareclient.com/pool/jammy/main/c/cloudflare-warp/cloudflare-warp_${PV}-1_amd64.deb"

LICENSE="all-rights-reserved"
RESTRICT="bindist mirror"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd +systray dex"
RDEPEND="net-firewall/nftables
	dex? ( net-libs/libpcap )
"

QA_PREBUILT="/bin/warp-cli /bin/warp-dex /bin/warp-diag /bin/warp-svc /bin/warp-taskbar"

S="${WORKDIR}"

src_unpack() {
	unpack_deb ${A}
}

src_install() {
	into /
	dobin bin/warp-cli
	dobin bin/warp-diag
	dobin bin/warp-svc
	doinitd "${FILESDIR}/warp-svc"
	systemd_dounit lib/systemd/system/warp-svc.service

	# warp-dex relies on "libpcap.so.0.8" which is not in tree.
	if use dex; then
		dobin bin/warp-dex
	fi

	if use systray; then
		dobin bin/warp-taskbar
		systemd_douserunit usr/lib/systemd/user/warp-taskbar.service

		doicon -s scalable $(ls usr/share/icons/hicolor/scalable/apps/*.svg)
		insinto /usr/share/warp/images
		doins $(ls usr/share/warp/images/*.png)

		desktopfile=$( \
			usex systemd \
			usr/share/applications/com.cloudflare.WarpTaskbar.desktop \
			"${FILESDIR}/com.cloudflare.WarpTaskbar.desktop" \
		)
		domenu $desktopfile

		insinto /etc/xdg/autostart
		doins $desktopfile
	fi
}
