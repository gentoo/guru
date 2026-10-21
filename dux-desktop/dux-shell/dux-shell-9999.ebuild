# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature shell-completion systemd go-module xdg

DESCRIPTION="Desktop shell for wayland compositors built with Quickshell"
HOMEPAGE="https://github.com/duxlabs-dev/dux-shell"

inherit git-r3
EGIT_REPO_URI="https://github.com/duxlabs-dev/dux-shell.git"

LICENSE="MIT"
SLOT="0"
IUSE="cups"

DEPEND="
	app-misc/jq
	dev-cpp/cli11
	dev-cpp/cpptrace[unwind]
	dev-qt/qtbase:6[dbus,wayland,opengl,vulkan,widgets]
	dev-qt/qtdeclarative:6[opengl,vulkan]
	dev-qt/qtmultimedia:6[dbus,opengl,vulkan,wayland]
	dev-qt/qtshadertools:6
	dev-qt/qtwayland:6
	gui-apps/quickshell
	sys-apps/accountsservice
	sys-apps/xdg-desktop-portal-gtk[wayland]
	sys-power/upower
	kde-frameworks/kimageformats
	cups? ( net-print/cups-pk-helper )
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	>=dev-lang/go-1.27.1
	dev-util/pkgconf
"

PATCHES=("${FILESDIR}"/"${PN}-2.0.0-no-strip.patch")

src_unpack() {
	git-r3_src_unpack
	pushd "${S}/core" >& /dev/null || die
		ego mod vendor
	popd >& /dev/null || die
}

src_compile() {
	cd core || die "Failed to cd"
	emake VERSION="${PV}" dist DIST_OSES=linux

	bin/dms-linux-"${ARCH}" completion bash > "${S}"/dms-bashcomp || die "Failed to generate bash completion"
	bin/dms-linux-"${ARCH}" completion zsh > "${S}"/dms-zshcomp || die "Failed to generate fish completion"
}

src_install() {
	newbin core/bin/dms-linux-"${ARCH}" dms

	newbashcomp dms-bashcomp dms
	newzshcomp dms-zshcomp _dms

	systemd_douserunit assets/systemd/dms.service

	domenu assets/dms-open.desktop
	doicon -s scalable assets/danklogo.svg
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature_header "Optional programs for extra features:"
	optfeature "Audio visualizer" media-sound/cava
	optfeature "I2C monitor brightness control" app-misc/ddcutil
	optfeature "Power profile options" sys-power/power-profiles-daemon
	optfeature "Volume & Speaker control" media-video/wireplumber
	optfeature "Bluetooth & file transfer" net-wireless/bluez
	optfeature "Calendar integration" app-misc/khal
	optfeature "Fingerprint unlock notifier" sys-auth/fprintd
	optfeature "Wallpaper based colorscheme" x11-misc/matugen
	optfeature "Wifi & Ethernet connection" net-misc/networkmanager
}
