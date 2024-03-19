# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8
inherit git-r3 systemd
DESCRIPTION="PinePhone Keyboard firmware and tools"
HOMEPAGE="https://xnux.eu/pinephone-keyboard/index.html"
EGIT_REPO_URI="https://xff.cz/git/pinephone-keyboard"
EGIT_COMMIT="1.2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~arm64"

# Needed for generating keymaps
BDEPEND=">=dev-lang/php-8.1.8"

src_prepare() {
	cat > "${S}/pinephone-keyboard.service" <<- EOF
		[Unit]
		Description=PinePhone Keyboard userspace daemon

		[Service]
		Type=simple
		ExecStart=/usr/sbin/ppkb-i2c-inputd
		Restart=on-failure
		RestartSec=10
		KillMode=process

		[Install]
		WantedBy=multi-user.target
		EOF

	default
}

src_install() {
	dosbin "${S}"/build/{ppkb-i2c-inputd,ppkb-i2c-charger-ctl,ppkb-i2c-flasher}
	dosbin "${S}"/build/{ppkb-i2c-debugger,ppkb-usb-flasher,ppkb-usb-debugger}
	systemd_dounit "${S}"/pinephone-keyboard.service
	dodoc -r COPYING HACKING README* TODO docs
}
