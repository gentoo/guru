# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Fork of official Telegram Desktop app with small useful additions - bin"
HOMEPAGE="https://github.com/Forkgram/tdesktop"

MY_PV="${PV}"
SRC_URI="
	https://github.com/Forkgram/tdesktop/releases/download/v${MY_PV}/Telegram.tar.xz -> ${P}.tar.xz
	https://raw.githubusercontent.com/Forkgram/tdesktop/dev/Telegram/Resources/art/icon16.png -> ${PN}-16.png
	https://raw.githubusercontent.com/Forkgram/tdesktop/dev/Telegram/Resources/art/icon32.png -> ${PN}-32.png
	https://raw.githubusercontent.com/Forkgram/tdesktop/dev/Telegram/Resources/art/icon48.png -> ${PN}-48.png
	https://raw.githubusercontent.com/Forkgram/tdesktop/dev/Telegram/Resources/art/icon64.png -> ${PN}-64.png
	https://raw.githubusercontent.com/Forkgram/tdesktop/dev/Telegram/Resources/art/icon128.png -> ${PN}-128.png
	https://raw.githubusercontent.com/Forkgram/tdesktop/dev/Telegram/Resources/art/icon256.png -> ${PN}-256.png
	https://raw.githubusercontent.com/Forkgram/tdesktop/dev/Telegram/Resources/art/icon512.png -> ${PN}-512.png
"

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="/usr/bin/forkgram"

RDEPEND="
	dev-libs/glib:2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng:0
	sys-apps/dbus
	virtual/opengl
	x11-libs/gtk+:3[X,wayland]
	x11-libs/libX11
	!!net-im/forkgram
	!!net-im/telegram-desktop
	!!net-im/telegram-desktop-bin
"

src_unpack() {
	unpack "${P}.tar.xz"
}

src_install() {
	newbin Telegram forkgram

	local size
	for size in 16 32 48 64 128 256 512; do
		newicon -s "${size}" "${DISTDIR}/${PN}-${size}.png" forkgram.png
	done

	make_desktop_entry forkgram Forkgram forkgram "Network;Chat;InstantMessaging;Qt;" "MimeType=x-scheme-handler/tg;"

	insinto /etc/tdesktop
	newins - externalupdater <<-EOF
		/usr/bin/forkgram
	EOF
}
