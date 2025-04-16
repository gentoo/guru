# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop rpm systemd shell-completion xdg

MYPV="${PV/_beta/-beta}"
DESCRIPTION="Tool used to manage daemon setup"
HOMEPAGE="https://github.com/mullvad/mullvadvpn-app https://mullvad.net/"
SRC_URI="
	amd64? ( https://github.com/mullvad/mullvadvpn-app/releases/download/${MYPV}/MullvadVPN-${MYPV}_x86_64.rpm )
	arm64? ( https://github.com/mullvad/mullvadvpn-app/releases/download/${MYPV}/MullvadVPN-${MYPV}_aarch64.rpm )
"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/pango
"

QA_PREBUILT="*"

src_install() {
	sed -i "s|SCRIPT_DIR=.*|SCRIPT_DIR=\"/opt/Mullvad VPN/\"|g" "${S}/opt/Mullvad VPN/mullvad-vpn" || die

	# Using doins -r would strip executable bits from all binaries
	cp -pPR opt "${D}"/ || die "Failed to copy files"
	fperms +x "/opt/Mullvad VPN/chrome_crashpad_handler"
	fperms 4755 "/opt/Mullvad VPN/chrome-sandbox"

	dobin ./usr/bin/mullvad
	dobin ./usr/bin/mullvad-daemon
	dobin ./usr/bin/mullvad-exclude
	dosym -r "/opt/Mullvad VPN/mullvad-vpn" /usr/bin/mullvad-vpn
	dosym -r "/opt/Mullvad VPN/resources/mullvad-problem-report" /usr/bin/mullvad-problem-report

	# mullvad-exclude uses cgroups to manage exclusions, which requires root permissions, but is
	# also most often used to exclude graphical applications which can't or shouldn't run as root
	# (i.e., can't be run under `sudo/doas /usr/bin/mullvad-exclude ...`, because `sudo`/`doas`
	# change user). The setuid bit allows any user to exclude executables under their own UID.
	fperms 4755 /usr/bin/mullvad-exclude

	newinitd "${FILESDIR}"/mullvad-daemon.initd mullvad-daemon

	systemd_newunit ./usr/lib/systemd/system/mullvad-daemon.service mullvad-daemon.service
	systemd_newunit ./usr/lib/systemd/system/mullvad-early-boot-blocking.service mullvad-early-boot-blocking.service

	newbashcomp ./usr/share/bash-completion/completions/mullvad mullvad
	newfishcomp ./usr/share/fish/vendor_completions.d/mullvad.fish mullvad
	newzshcomp ./usr/share/zsh/site-functions/_mullvad _mullvad

	domenu ./usr/share/applications/mullvad-vpn.desktop
	local x
	for x in 16 32 48 64 128 256 512 1024; do
		doicon -s "${x}" "./usr/share/icons/hicolor/${x}x${x}/apps/mullvad-vpn.png"
	done
}

MULLVAD_IS_BEING_UPDATED=false

pkg_preinst() {
	xdg_pkg_preinst

	[[ -n "$(best_version "${CATEGORY}/${PN}")" ]] && MULLVAD_IS_BEING_UPDATED=true
}

pkg_postrm() {
	xdg_pkg_postrm

	if [[ ${MULLVAD_IS_BEING_UPDATED} = "false" ]]; then
		if ! command -v pgrep &>/dev/null || pgrep -f "mullvad-(daemon|gui)"; then
			elog "Mullvad has been uninstalled. To stop the service,"
			elog "1. Quit the Mullvad app"
			elog "   * Manually: 'Disconnect & quit' from the Mullvad menu"
			elog "     OR"
			elog "   * Command line: pkill -f mullvad-gui"
			elog "2. Stop the daemon"
			elog "   * OpenRC: rc-service mullvad-daemon stop"
			elog "     OR"
			elog "   * systemd: systemctl stop mullvad-daemon"
			elog "     OR"
			elog "   * other: pkill -f mullvad-daemon"
		fi
	fi
}

pkg_postinst() {
	xdg_pkg_postinst

	if [[ ${MULLVAD_IS_BEING_UPDATED} = "true" ]]; then
		if command -v pgrep &>/dev/null && pgrep -f "mullvad-(daemon|gui)" &>/dev/null; then
			elog "Mullvad has been updated. To restart the service,"
			elog "1. Restart the daemon"
			elog "   * OpenRC: rc-service mullvad-daemon restart"
			elog "     OR"
			elog "   * systemd: systemctl restart mullvad-daemon"
			elog "2. Restart the app"
			elog "   * Manually: 'Disconnect & quit' from the Mullvad menu and relaunch using"
			elog "               your preferred desktop launcher"
			elog "     OR"
			elog "   * Command line: pkill -f mullvad-gui && '/opt/Mullvad VPN/mullvad-vpn' & disown"
		else
			elog "Mullvad has been updated. To start the service,"
			elog "1. Start the daemon"
			elog "   * OpenRC: rc-service mullvad-daemon start"
			elog "     OR"
			elog "   * systemd: systemctl start mullvad-daemon"
			elog "2. Launch the app"
			elog "   * Manually: use your preferred desktop launcher"
			elog "     OR"
			elog "   * Command line: '/opt/Mullvad VPN/mullvad-vpn' & disown"
		fi
	else
		elog "Mullvad has been installed. To start the service,"
		elog "1. Enable and start the daemon"
		elog "   * OpenRC: rc-update add mullvad-daemon default"
		elog "             rc-service mullvad-daemon start"
		elog "     OR"
		elog "   * systemd: systemctl enable mullvad-daemon"
		elog "              systemctl start mullvad-daemon"
		elog "2. Launch the app"
		elog "   * Manually: use your preferred desktop launcher"
		elog "     OR"
		elog "   * Command line: '/opt/Mullvad VPN/mullvad-vpn' & disown"
	fi
}
