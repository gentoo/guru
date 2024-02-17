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
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_prepare() {
	default
	xdg_environment_reset
}

src_unpack() {
	rpm_unpack ${P}.x86_64.rpm
}

QA_PREBUILT="opt/1Password/*"

QA_SONAME="
/usr/lib64/libXcomposite.so.1
/usr/lib64/libXdamage.so.1
/usr/lib64/libXfixes.so.3
/usr/lib64/libXrandr.so.2
/usr/lib64/libasound.so.2
/usr/lib64/libatk-1.0.so.0
/usr/lib64/libatk-bridge-2.0.so.0
/usr/lib64/libatspi.so.0
/usr/lib64/libcups.so.2
/usr/lib64/libdrm.so.2
/usr/lib64/libgbm.so.1
/usr/lib64/libgtk-3.so.0
/usr/lib64/libnspr4.so
/usr/lib64/libnss3.so
/usr/lib64/libnssutil3.so
/usr/lib64/libpango-1.0.so.0
/usr/lib64/libsmime3.so
/usr/lib64/libxkbcommon.so.0
"

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
