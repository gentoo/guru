# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop rpm systemd shell-completion xdg

DESCRIPTION="Tool used to manage daemon setup"
HOMEPAGE="https://github.com/mullvad/mullvadvpn-app https://mullvad.net/"
SRC_URI="
	amd64? ( https://github.com/mullvad/mullvadvpn-app/releases/download/${PV}/MullvadVPN-${PV}_x86_64.rpm )
	arm64? ( https://github.com/mullvad/mullvadvpn-app/releases/download/${PV}/MullvadVPN-${PV}_aarch64.rpm )
"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	net-print/cups
	x11-libs/gtk+
	x11-libs/libdrm
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/pango
"

QA_PREBUILT="*"

src_install() {
	sed -i "s|SCRIPT_DIR=.*|SCRIPT_DIR=\"/opt/Mullvad VPN/\"|g" "${S}"/opt/Mullvad\ VPN/mullvad-vpn

	# Using doins -r would strip executable bits from all binaries
	cp -pPR "${S}"/opt "${D}"/ || die "Failed to copy files"
	fperms +x "/opt/Mullvad VPN/chrome_crashpad_handler"
	fperms 4755 "/opt/Mullvad VPN/chrome-sandbox"

	dobin "${S}"/usr/bin/mullvad
	dobin "${S}"/usr/bin/mullvad-daemon
	dobin "${S}"/usr/bin/mullvad-exclude
	dosym "../../opt/Mullvad VPN/mullvad-vpn" /usr/bin/mullvad-vpn
	dosym "../../opt/Mullvad VPN/resources/mullvad-problem-report" /usr/bin/mullvad-problem-report

	# mullvad-exclude uses cgroups to manage exclusions, which requires root permissions, but is
	# also most often used to exclude graphical applications which can't or shouldn't run as root
	# (i.e., can't be run under `sudo/doas /usr/bin/mullvad-exclude ...`, because `sudo`/`doas`
	# change user). The setuid bit allows any user to exclude executables under their own UID.
	fperms 4755 /usr/bin/mullvad-exclude

	newinitd "${FILESDIR}"/mullvad-daemon.initd mullvad-daemon

	systemd_newunit "${S}"/usr/lib/systemd/system/mullvad-daemon.service mullvad-daemon.service
	systemd_newunit "${S}"/usr/lib/systemd/system/mullvad-early-boot-blocking.service mullvad-early-boot-blocking.service

	newbashcomp "${S}"/usr/share/bash-completion/completions/mullvad mullvad
	newfishcomp "${S}"/usr/share/fish/vendor_completions.d/mullvad.fish mullvad
	newzshcomp "${S}"/usr/share/zsh/site-functions/_mullvad _mullvad

	domenu "${S}"/usr/share/applications/mullvad-vpn.desktop
	local x
	for x in 16 32 48 64 128 256 512 1024; do
		doicon -s ${x} "${S}"/usr/share/icons/hicolor/${x}x${x}/apps/mullvad-vpn.png
	done
}
