# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta package for Phosh"
HOMEPAGE="https://github.com/dreemurrs-embedded/Pine64-Arch"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	app-editors/gedit
	app-mobilephone/mobile-config-firefox
	app-mobilephone/flashlight
	app-text/evince
	gnome-base/gnome-control-center
	gnome-extra/gnome-contacts
	media-video/megapixels
	gnome-extra/gnome-calculator
	gnome-extra/gnome-calendar
	gui-wm/phosh
	net-voip/calls
	net-im/chatty
	net-dns/dnsmasq
	sys-power/gtherm
	sys-auth/rtkit
	x11-misc/squeekboard
	x11-terms/gnome-terminal
	x11-themes/sound-theme-librem5
	www-client/epiphany
"

RDEPEND="${DEPEND}"

S="${WORKDIR}"

pkg_postinst() {
	[ -e /usr/share/applications-bak ] || mkdir /usr/share/applications-bak
	for i in vim org.gnupg.pinentry-qt org.gnome.Extensions mupdf \
	gnome-printers-panel gnome-wifi-pannel pidgin wpa_gui cups \
	Gentoo-system-config-printer
	do
		if [ -e /usr/share/applications/$i.desktop ]; then
			mv /usr/share/applications/$i.desktop /usr/share/applications-bak
		fi
	done
}
