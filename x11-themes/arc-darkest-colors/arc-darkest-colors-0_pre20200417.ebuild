# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils

MY_COMMIT="aee10fc647fd0cdb8ef9907ae3ee42c1bea5d976"

DESCRIPTION="Flat, dark-mode theme with transparent elements"
HOMEPAGE="https://github.com/rtlewis88/rtl88-Themes/tree/Arc-Darkest-COLORS-Complete-Desktop"
SRC_URI="https://github.com/rtlewis88/rtl88-Themes/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="icons"

RDEPEND="x11-themes/gtk-engines-murrine"

S="${WORKDIR}/rtl88-Themes-${MY_COMMIT}"

src_install() {
	for color in BlueAgave Kiwi Plum Strawberry Tangerine; do
		insinto "usr/share/themes"
		doins -r "AD-${color}"
		if use icons; then
			insinto "usr/share/icons"
			for variant in Numix Suru; do
				doins -r "AD-${color}-${variant}"
			done
		fi
	done

	default
}

pkg_postinst() {
	use icons && xdg_icon_cache_update
}

pkg_postrm() {
	use icons && xdg_icon_cache_update
}
