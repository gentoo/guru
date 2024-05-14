# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="An unofficial WhatsApp desktop application for Linux"
HOMEPAGE="https://github.com/eneshecan/whatsapp-for-linux"
SRC_URI="https://github.com/eneshecan/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

LANGUAGES="en es it ka nl pt-BR ru tr"
for lang in ${LANGUAGES}; do
	IUSE+=" +l10n_${lang}"
done

RDEPEND="
	dev-cpp/atkmm
	dev-cpp/glibmm:2
	dev-cpp/gtkmm:3.0
	dev-libs/glib
	dev-libs/libayatana-appindicator
	dev-libs/libsigc++:2
	media-libs/libcanberra
	|| (
		net-libs/webkit-gtk:4
		net-libs/webkit-gtk:4.1
	)
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"

BDEPEND="dev-util/intltool"

src_prepare() {
	cmake_src_prepare
	for lang in ${LANGUAGES}; do
		if ! use l10n_${lang}; then
			rm "${S}/po/${lang,,}.po" || die "Failed to remove localization"
			sed -i -e "/${lang,,}/d" "${S}/po/LINGUAS" || die
		fi
	done
}
