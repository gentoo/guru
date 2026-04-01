# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="BambuStudio"
WX_GTK_VER="3.2-gtk3"

inherit desktop wrapper xdg

DESCRIPTION="Bambu Studio is a cutting-edge, feature-rich slicing software"
HOMEPAGE="https://bambulab.com"

SRC_URI="
	https://github.com/bambulab/${MY_PN}/releases/download/v${PV}/Bambu_Studio_linux_fedora-v02.05.00.66.AppImage \
	-> ${P}.AppImage
"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
RDEPEND="
	media-gfx/openvdb
	media-libs/glew:0=
	>=media-libs/glm-0.9.9.1
	media-libs/gstreamer
	media-libs/libglvnd
	media-libs/mesa
	net-libs/libsoup:2.4
	net-libs/webkit-gtk:4.1
	>=sci-libs/opencascade-7.3.0:0=
	virtual/glu
	>=x11-libs/cairo-1.8.8:=
	x11-libs/libxkbcommon
	>=x11-libs/pixman-0.30
	x11-libs/wxGTK:${WX_GTK_VER}=[X,opengl]
	virtual/zlib
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-util/patchelf
"

QA_PREBUILT="*"
# libOSMesa.so.8 (mesa no longer provides osmesa)
# libwebkit2gtk-4.0.so.37 / libjavascriptcoregtk-4.0.so.18 (webkit-gtk:4 removed from tree)
# These are optional runtime deps that the AppImage can function without
QA_FLAGS_IGNORED="opt/bambustudio-bin/.*"
RESTRICT="strip test"

src_unpack() {
	mkdir "${S}" || die
	cp "${DISTDIR}/${P}.AppImage" "${S}"/ || die
	pushd "${S}" || die
	chmod +x "${S}/${P}.AppImage" || die
	"${S}/${P}.AppImage" --appimage-extract || die
	rm "${S}/${P}.AppImage" || die
	popd || die
}

src_install() {
	patchelf --set-rpath '$ORIGIN' \
		"${S}"/squashfs-root/bin/bambu-studio || die
	insinto /opt/"${PN}"
	doins -r "${S}"/squashfs-root/*
	fperms +x "/opt/${PN}/AppRun" "/opt/${PN}/bin/bambu-studio"
	doicon -s 192 "${S}"/squashfs-root/BambuStudio.png
	domenu "${FILESDIR}/bambu-studio.desktop"
	make_wrapper bambu-studio "/opt/${PN}/AppRun"
}
