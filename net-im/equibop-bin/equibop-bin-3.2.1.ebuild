# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit desktop xdg

DESCRIPTION="A custom Discord desktop app with Equicord pre-installed (binary release)"
HOMEPAGE="https://github.com/Equicord/Equibop"
SRC_URI="
	https://raw.githubusercontent.com/Equicord/Equibop/v${PV}/static/icon.png -> ${PN}-icon.png
	amd64? ( ${HOMEPAGE}/releases/download/v${PV}/equibop-${PV}.tar.gz -> ${P}-x86_64.tar.gz )
	arm64? ( ${HOMEPAGE}/releases/download/v${PV}/equibop-${PV}-arm64.tar.gz -> ${P}-aarch64.tar.gz )
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

S="${WORKDIR}/equibop-${PV}"

RDEPEND="
	!net-im/equibop
	dev-libs/glib:2
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libxcb
	x11-libs/libXScrnSaver
	dev-libs/nss
	dev-libs/nspr
	media-libs/alsa-lib
"
DEPEND="${RDEPEND}"

QA_PREBUILT="
	usr/share/equibop-bin/equibop
	usr/share/equibop-bin/chrome-sandbox
	usr/share/equibop-bin/libffmpeg.so
	usr/share/equibop-bin/libEGL.so
	usr/share/equibop-bin/libGLESv2.so
	usr/share/equibop-bin/libvk_swiftshader.so
	usr/share/equibop-bin/libvulkan.so.1
"

src_unpack() {
	default
}

src_prepare() {
	default
}

src_install() {
	insinto /usr/share/equibop-bin
	doins -r *

	fperms +x /usr/share/equibop-bin/equibop
	if [[ -f "${ED}/usr/share/equibop-bin/chrome-sandbox" ]]; then
		fperms 4755 /usr/share/equibop-bin/chrome-sandbox
	fi

	dodir /usr/bin
	dosym ../share/equibop-bin/equibop /usr/bin/equibop-bin

	newicon "${DISTDIR}/${PN}-icon.png" equibop-bin.png

	make_desktop_entry "equibop-bin --ozone-platform-hint=auto %U" "Equibop (Bin)" "equibop-bin" "Network;InstantMessaging;Chat;" "MimeType=x-scheme-handler/discord;\nStartupWMClass=equibop"
}