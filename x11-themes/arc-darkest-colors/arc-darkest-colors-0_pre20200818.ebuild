# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg

MY_COMMIT="ea335b539ebf29df5b4605812c9844bd8c409fc6"

DESCRIPTION="Flat, dark-mode theme with transparent elements"
HOMEPAGE="https://github.com/rtlewis88/rtl88-Themes/tree/Arc-Darkest-COLORS-Complete-Desktop"
SRC_URI="https://github.com/rtlewis88/rtl88-Themes/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/rtl88-Themes-${MY_COMMIT}"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="icons"

RDEPEND="x11-themes/gtk-engines-murrine"

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
