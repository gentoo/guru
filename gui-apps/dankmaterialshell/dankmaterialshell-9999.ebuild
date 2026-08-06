# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature shell-completion systemd xdg-utils go-module

DESCRIPTION="Desktop shell for wayland compositors built with Quickshell"
HOMEPAGE="https://github.com/AvengeMedia/DankMaterialShell"

inherit git-r3
EGIT_REPO_URI="https://github.com/AvengeMedia/DankMaterialShell.git"

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
	>=dev-lang/go-1.26.4
	dev-util/pkgconf
"

# set variables
QML_DIR="${S}"/quickshell # qml assets location
CLI_DIR="${S}"/core

src_unpack() {
	git-r3_src_unpack
	cd "${CLI_DIR}"
	ego mod vendor
	rm "${QML_DIR}"/DankCommon
	cp -r "${S}"/dank-qml-common/DankCommon "${QML_DIR}"/DankCommon
}

src_prepare() {
	default
	cd "${CLI_DIR}"
	eapply "${FILESDIR}"/"${PN}-1.5.3-no-strip.patch"
}

src_configure() {
	cd "${CLI_DIR}"
	default
}

src_compile() {
	cd "${CLI_DIR}"
	# build dms distro binary
	emake VERSION="${PV}" DIST_OSES="linux" dist

	# generate shell completions
	"${CLI_DIR}"/bin/dms-linux-"${ARCH}" completion bash > "${CLI_DIR}"/dms-bashcomp
	"${CLI_DIR}"/bin/dms-linux-"${ARCH}" completion zsh > "${CLI_DIR}"/dms-zshcomp
}

src_install() {
	# install dms binary
	newbin "${CLI_DIR}"/bin/dms-linux-"${ARCH}" dms

	# install qml sources at /usr/share/quickshell/dms
	insinto /usr/share/quickshell/dms
	doins -r "${QML_DIR}/."

	# install shell completions
	newbashcomp "${CLI_DIR}"/dms-bashcomp dms
	newzshcomp "${CLI_DIR}"/dms-zshcomp _dms

	# systemd unit
	systemd_douserunit "${S}"/assets/systemd/dms.service

	# desktop entry and icon
	domenu "${S}"/assets/dms-open.desktop
	doicon -s scalable "${S}"/assets/danklogo.svg
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update

	optfeature_header "Optional programs for extra features:"
	optfeature "Audio visualizer" media-sound/cava
	optfeature "I2C monitor brightness control" app-misc/ddcutil
	optfeature "Power profile options" sys-power/power-profiles-daemon
	optfeature "Volume & Speaker control" media-video/wireplumber
	optfeature "Bluetooth & file transfer" net-wireless/bluez
	optfeature "Calendar integration" app-misc/khal
	optfeature "Fingerprint unlock notifier" sys-auth/fprintfd
	optfeature "Wallpaper based colorscheme" x11-misc/matugen
	optfeature "Wifi & Ethernet connection" net-misc/networkmanager
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
