# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit desktop unpacker xdg

DESCRIPTION="GUI Guider is a user-friendly GUI development tool for LVGL"
HOMEPAGE="https://www.nxp.com/design/design-center/software/development-software/gui-guider"
SRC_URI="
	Gui-Guider-Setup-${PV}-GA.deb
"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="bindist fetch strip"

RDEPEND="
	dev-libs/libappindicator
	dev-libs/libffi
	dev-libs/nss
	media-libs/libsdl2
	media-libs/vips
	x11-libs/libnotify
	x11-libs/libXtst
"
DEPEND="${RDEPEND}"
BDEPEND="dev-util/patchelf"

QA_PREBUILT="*"
DOCS=( "opt/Gui-Guider/EULA.txt" )

pkg_nofetch() {
	einfo "${PN} requires you to accept their license agreement before downloading."
	einfo "Download ${SRC_URI}"
	einfo "with your browser and place it in DISTDIR (usually /var/cache/distfiles/)"
	einfo "Please place the ${P} installation file ${SRC_URI}"
	einfo "in your \$\{DISTDIR\}."
}

src_install() {
	insinto "/opt"
	doins -r opt/Gui-Guider
	# Fix RPATHs to ensure the libraries can be found
	pushd "${D}/opt/Gui-Guider" || die
	for f in $(find .) ; do
		[[ -f "${f}" && $(od -t x1 -N 4 "${f}") == *"7f 45 4c 46"* ]] || continue
		fperms 0755 "/opt/Gui-Guider/${f}"
		[[ "${f: -4}" != ".cfx" ]] || continue
		patchelf --set-rpath "/opt/Gui-Guider" "${f}" || die "patchelf failed on ${f}"
	done
	popd || die
	for f in $(find "${D}/opt/Gui-Guider/environment/LinkServer/linux/binaries") ; do
		[[ -f "${f}" && $(od -t x1 -N 4 "${f}") == *"7f 45 4c 46"* ]] || continue
		[[ "${f: -4}" != ".cfx" ]] || continue
		patchelf --set-rpath \
"/opt/Gui-Guider/environment/LinkServer/linux/binaries:\
/opt/Gui-Guider/environment/LinkServer/linux/dist:\
/opt/Gui-Guider/environment/LinkServer/linux/MCU-LINK_installer/bin:\
/opt/Gui-Guider/environment/LinkServer/linux/dist/lib-dynload" \
			"${f}" || die "patchelf failed on ${f}"
	done
	for i in 16 32 64 128 256 512; do
		png_file="usr/share/icons/hicolor/${i}x${i}/apps/Gui-Guider.png"
		if [ -e "${png_file}" ]; then
			newicon -s "${i}" "${png_file}" "Gui-Guider.png"
		fi
	done
	domenu "usr/share/applications/Gui-Guider.desktop"
	einstalldocs
}
