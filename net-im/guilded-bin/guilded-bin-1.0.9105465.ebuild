# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=${PN/-bin/}
MY_BIN="G${MY_PN/g/}"

inherit desktop linux-info pax-utils unpacker xdg

DESCRIPTION="Drop Discord, get Guilded"
HOMEPAGE="https://www.guilded.gg"
SRC_URI="https://www.guilded.gg/downloads/${MY_BIN}-Linux.deb -> ${P}.deb"

S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror bindist"

RDEPEND="
	app-accessibility/at-spi2-atk
	app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/libappindicator
	net-print/cups
	media-libs/alsa-lib
	sys-apps/util-linux
	x11-misc/xdg-utils
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	x11-libs/libX11
	x11-libs/libXtst
	dev-libs/nss
"

QA_PREBUILT="
	opt/${MY_BIN}/${MY_PN}
	opt/${MY_BIN}/chrome-sandbox
	opt/${MY_BIN}/crashpad_handler
	opt/${MY_BIN}/libffmpeg.so
	opt/${MY_BIN}/libvk_swiftshader.so
	opt/${MY_BIN}/libEGL.so
	opt/${MY_BIN}/libGLESv2.so
	opt/${MY_BIN}/swiftshader/libEGL.so
	opt/${MY_BIN}/swiftshader/libGLESv2.so
	opt/${MY_BIN}/resources/*
"

CONFIG_CHECK="~USER_NS"

src_prepare() {
	default

	sed -i \
		-e "s:/usr/share/${MY_PN}/${MY_BIN}:/opt/${MY_BIN}/${MY_PN}:g" \
		usr/share/applications/${MY_PN}.desktop || die
}

src_install() {
	newicon usr/share/icons/hicolor/512x512/apps/${MY_PN}.png ${MY_PN}.png
	domenu usr/share/applications/${MY_PN}.desktop

	insinto /opt/${MY_BIN}
	doins -r opt/${MY_BIN}/.
	fperms +x /opt/${MY_BIN}/${MY_PN}
	dosym ../../opt/${MY_BIN}/${MY_PN} usr/bin/${MY_PN}

	pax-mark -m "${ED}"/opt/${MY_BIN}/${MY_PN}
}
