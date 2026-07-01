# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Omnissa Horizon Client for Linux"
HOMEPAGE="https://www.omnissa.com/products/horizon-8/ https://customerconnect.omnissa.com/downloads/info/slug/virtual_desktop_and_apps/omnissa_horizon_clients/8"

VER1="CART27FQ1_LIN_2603"
VER2="8.18.0-24120621798"

SRC_URI="https://download3.omnissa.com/software/${VER1}_TARBALL/Omnissa-Horizon-Client-Linux-${PV}-${VER2}.tar.gz"

S="${WORKDIR}"

LICENSE="omnissa"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror strip"
QA_SONAME="usr/lib64/libpcoip_client.so"

inherit xdg

RDEPEND="media-libs/libva-compat[X]
x11-libs/libvdpau
dev-libs/libxml2-compat
dev-libs/glib
dev-libs/openssl
media-libs/libpng
x11-libs/cairo
x11-libs/libX11
x11-libs/libXext
x11-libs/libXrender
dev-util/lttng-ust-compat
sys-apps/pcsc-lite
"

src_unpack() {
	unpack "Omnissa-Horizon-Client-Linux-${PV}-${VER2}.tar.gz"
	unpack "Omnissa-Horizon-Client-Linux-${PV}-${VER2}/x64/Omnissa-Horizon-Client-${PV}-${VER2}.x64.tar.gz"
	unpack "Omnissa-Horizon-Client-Linux-${PV}-${VER2}/x64/Omnissa-Horizon-PCoIP-${PV}-${VER2}.x64.tar.gz"
}

src_prepare() {
	cd "${WORKDIR}"/Omnissa-Horizon-Client-"${PV}"-"${VER2}".x64
	sed -i 's:/usr/lib/:/usr/lib64/:g' usr/bin/*
	sed -i 's/Categories=Application;/Categories=/g' usr/share/applications/*.desktop

	eapply_user
}

src_install() {
	cd "${WORKDIR}"/Omnissa-Horizon-Client-"${PV}"-"${VER2}".x64/usr

	for binfile in bin/*; do
		dobin "${binfile}"
	done

	insinto /usr/lib64
	doins lib/libclientSdkCPrimitive.so
	doins -r lib/omnissa
	exeinto /usr/lib64/omnissa/horizon/bin/
	for binfile in lib/omnissa/horizon/bin/*; do
		doexe "${binfile}"
	done

	insinto /usr/share
	doins -r share/applications
	doins -r share/icons
	doins -r share/locale
	doins -r share/pixmaps
	#doins -r share/X11

#	dodoc -r share/doc

	cd "${WORKDIR}"/Omnissa-Horizon-PCoIP-"${PV}"-"${VER2}".x64/usr
	insinto /usr/lib64
	dolib.so lib/libpcoip_client.so
	doins -r lib/omnissa
	doins -r lib/pcoip

	exeinto /usr/lib64/omnissa/horizon/client
	doexe lib/omnissa/horizon/client/horizon-protocol
}
