# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit desktop unpacker xdg

DESCRIPTION="GUI Guider is a user-friendly GUI development tool for LVGL"
HOMEPAGE="https://www.nxp.com/design/design-center/software/development-software/gui-guider"
SRC_URI="
	GUIGuider-${PV}-amd64.deb
"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="bindist fetch strip"

RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/libayatana-appindicator
	dev-libs/libffi
	dev-libs/nss
	media-libs/libsdl2
	virtual/libusb:1
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	x11-libs/libXtst
"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/patchelf"

QA_PREBUILT="*"
DOCS=( "opt/GUIGuider/EULA.html" )

pkg_nofetch() {
	einfo "${PN} requires you to accept their license agreement before downloading."
	einfo "Download ${SRC_URI}"
	einfo "with your browser and place it in DISTDIR (usually /var/cache/distfiles/)"
	einfo "Please place the ${P} installation file ${SRC_URI}"
	einfo "in your \$\{DISTDIR\}."
}

src_install() {
	insinto "/opt"
	doins -r opt/GUIGuider
	# Fix RPATHs to ensure the libraries can be found
	pushd "${D}/opt/GUIGuider" || die
	for f in $(find .) ; do
		[[ -f "${f}" && $(od -t x1 -N 4 "${f}") == *"7f 45 4c 46"* ]] || continue
		fperms 0755 "/opt/GUIGuider/${f}"
	done
	popd || die
	local linkserver="/opt/GUIGuider/resources/assets/LinkServer/linux/binaries"
	pushd "${D}${linkserver}" || die
	for f in $(find .) ; do
		[[ -f "${f}" && $(od -t x1 -N 4 "${f}") == *"7f 45 4c 46"* ]] || continue
		# .cfx are statically linked ARM flash algorithms
		[[ "${f: -4}" != ".cfx" ]] || continue
		patchelf --set-rpath "${linkserver}" "${f}" || die "patchelf failed on ${f}"
	done
	popd || die
	newicon -s 512 "usr/share/icons/hicolor/512x512/apps/guiguider.png" "guiguider.png"
	domenu "usr/share/applications/guiguider.desktop"
	einstalldocs
}
