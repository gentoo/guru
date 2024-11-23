# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker systemd xdg desktop

DESCRIPTION="Cloudflare Warp Client"
HOMEPAGE="https://one.one.one.one"
SRC_URI="https://pkg.cloudflareclient.com/pool/jammy/main/c/cloudflare-warp/cloudflare-warp_${PV}.0_amd64.deb"

S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd +systray dex"
RESTRICT="bindist mirror"
RDEPEND="net-firewall/nftables
	dex? ( net-libs/libpcap )
	systray? (
		x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:3
		x11-libs/pango
	)
"

QA_PREBUILT="/bin/warp-cli /bin/warp-dex /bin/warp-diag /bin/warp-svc /bin/warp-taskbar"

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
