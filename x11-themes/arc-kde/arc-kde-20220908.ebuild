# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="Port of the popular GTK theme Arc for Plasma 5"
HOMEPAGE="https://github.com/PapirusDevelopmentTeam/arc-kde"
SRC_URI="https://github.com/PapirusDevelopmentTeam/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"

pkg_postinst() {
	optfeature "Kvantum theme engine support" x11-themes/kvantum
	optfeature "GTK support" x11-themes/arc-theme
}
