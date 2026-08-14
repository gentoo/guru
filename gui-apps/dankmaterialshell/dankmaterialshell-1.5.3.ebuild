# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop optfeature shell-completion systemd xdg

DESCRIPTION="Desktop shell for wayland compositors built with Quickshell"
HOMEPAGE="https://github.com/AvengeMedia/DankMaterialShell"
# dms source code & QML (quickshell) files
SRC_URI="https://github.com/AvengeMedia/DankMaterialShell/releases/download/v${PV}/dms-cli-${PV}.tar.gz
	https://github.com/AvengeMedia/DankMaterialShell/releases/download/v${PV}/dms-qml.tar.gz -> dms-qml-${PV}.tar.gz"

S="${WORKDIR}/dms-cli-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
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
	dev-lang/go
	dev-util/pkgconf
"

PATCHES=("${FILESDIR}"/"${PN}-1.5.3-no-strip.patch")

# set variables
QML_DIR="${WORKDIR}"/dms # qml assets location

src_unpack() {
	# unpack dms source
	unpack dms-cli-"${PV}".tar.gz
	# unpack QML assets in ${QML_DIR}
	mkdir -p ${QML_DIR} || die "failed to create directory: ${QML_DIR}"
	cd "${QML_DIR}"  || die "cd into ${QML_DIR} failed"
	unpack dms-qml-"${PV}".tar.gz
}

src_compile() {
	# build dms distro binary
	emake VERSION="${PV}" dist

	# generate shell completions
	"${S}"/bin/dms-linux-"${ARCH}" completion bash > "${S}"/dms-bashcomp
	"${S}"/bin/dms-linux-"${ARCH}" completion zsh > "${S}"/dms-zshcomp
}

src_install() {
	# install dms binary
	newbin "${S}"/bin/dms-linux-"${ARCH}" dms

	# install qml sources at /usr/share/quickshell/dms
	insinto /usr/share/quickshell
	doins -r "${QML_DIR}"

	# install shell completions
	newbashcomp "${S}"/dms-bashcomp dms
	newzshcomp "${S}"/dms-zshcomp _dms

	# systemd unit
	systemd_douserunit "${QML_DIR}"/assets/systemd/dms.service

	# desktop entry and icon
	domenu "${QML_DIR}"/assets/dms-open.desktop
	doicon -s scalable "${QML_DIR}"/assets/danklogo.svg
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
	optfeature "Fingerprint unlock notifier" sys-auth/fprintfd
	optfeature "Wallpaper based colorscheme" x11-misc/matugen
	optfeature "Wifi & Ethernet connection" net-misc/networkmanager
}
