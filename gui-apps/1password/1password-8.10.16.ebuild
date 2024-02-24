# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rpm xdg-utils optfeature

DESCRIPTION="The world’s most-loved password manager"
HOMEPAGE="https://1password.com"
SRC_URI="amd64? ( https://downloads.1password.com/linux/rpm/stable/x86_64/${P}.x86_64.rpm )"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="mirror strip test bindist"

DEPEND="
	x11-misc/xdg-utils
	acct-group/1password
"
RDEPEND="
	${DEPEND}
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXrandr
	media-libs/alsa-lib
	app-accessibility/at-spi2-core
	net-print/cups
	x11-libs/libdrm
	media-libs/mesa
	x11-libs/gtk+
	dev-libs/nspr
	dev-libs/nss
	x11-libs/pango
	x11-libs/libxkbcommon
"

S=${WORKDIR}

src_prepare() {
	default
	xdg_environment_reset
}

src_unpack() {
	rpm_unpack ${P}.x86_64.rpm
}

QA_PREBUILT="opt/1Password/*"

src_install() {
	cp -ar "${S}/opt"  "${D}" || die "Install failed!"
	cp -ar "${S}/usr"  "${D}" || die "Install failed!"

	chgrp 1password "${D}/opt/1Password/1Password-BrowserSupport" || die

	dosym ../../opt/1Password/1password /usr/bin/1password
}

pkg_postinst() {
	chmod 4755 /opt/1Password/chrome-sandbox
	chmod 6755 /opt/1Password/1Password-KeyringHelper
	chmod 2755 /opt/1Password/1Password-BrowserSupport

	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update

	optfeature "cli support" app-misc/1password-cli
	optfeature "policykit support" sys-auth/polkit
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
