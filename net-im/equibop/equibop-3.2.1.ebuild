# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit desktop xdg

DESCRIPTION="A custom Discord desktop app with Equicord pre-installed"
HOMEPAGE="https://github.com/Equicord/Equibop"
SRC_URI="https://github.com/Equicord/Equibop/archive/refs/tags/v${PV}.tar.gz -> ${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="network-sandbox"

S="${WORKDIR}/Equibop-${PV}"

BDEPEND="
	dev-lang/bun-bin
	net-libs/nodejs
	sys-devel/gcc
	dev-build/cmake
"

RDEPEND="
	!net-im/equibop-bin
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
	usr/share/equibop/equibop
	usr/share/equibop/chrome-sandbox
	usr/share/equibop/libffmpeg.so
	usr/share/equibop/libEGL.so
	usr/share/equibop/libGLESv2.so
	usr/share/equibop/libvk_swiftshader.so
	usr/share/equibop/libvulkan.so.1
"

src_prepare() {
	default
	cp "${FILESDIR}/equibop.sh" "${T}/equibop.sh" || die
	sed -i 's|exec electron40 /usr/lib/equibop/app.asar|exec /usr/share/equibop/equibop|' "${T}/equibop.sh" || die
}

src_compile() {
	export SKIP_BUN_DOWNLOAD=true
	
	bun install || die
	bun run buildLibVesktop || die
	
	# Blokujemy automatyczne próby wypychania paczki do sieci przez electron-builder
	export CI=false
	bun run package:dir -- --publish never || die
}

src_install() {
	insinto /usr/share/equibop
	doins -r dist/linux-unpacked/*

	fperms +x /usr/share/equibop/equibop
	if [[ -f "${ED}/usr/share/equibop/chrome-sandbox" ]]; then
		fperms 4755 /usr/share/equibop/chrome-sandbox
	fi

	newbin "${T}/equibop.sh" equibop

	newicon static/icon.png equibop.png

	domenu "${FILESDIR}/equibop.desktop"

	einstalldocs
}