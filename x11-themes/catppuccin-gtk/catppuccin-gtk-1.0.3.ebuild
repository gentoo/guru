# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Soothing pastel theme for GTK"
HOMEPAGE="https://github.com/catppuccin"

MY_URI="https://github.com/catppuccin/gtk/releases/download/v${PV}/"
MY_FRAPPE="catppuccin-frappe"
MY_LATTE="catppuccin-latte"
MY_MACCHIATO="catppuccin-macchiato"
MY_MOCHA="catppuccin-mocha"

SRC_URI="
	frappe? (
		${MY_URI}/${MY_FRAPPE}-blue-standard+default.zip      -> ${P}-frappe-blue.zip
		${MY_URI}/${MY_FRAPPE}-flamingo-standard+default.zip  -> ${P}-frappe-flamingo.zip
		${MY_URI}/${MY_FRAPPE}-green-standard+default.zip     -> ${P}-frappe-green.zip
		${MY_URI}/${MY_FRAPPE}-lavender-standard+default.zip  -> ${P}-frappe-lavender.zip
		${MY_URI}/${MY_FRAPPE}-maroon-standard+default.zip    -> ${P}-frappe-maroon.zip
		${MY_URI}/${MY_FRAPPE}-mauve-standard+default.zip     -> ${P}-frappe-mauve.zip
		${MY_URI}/${MY_FRAPPE}-peach-standard+default.zip     -> ${P}-frappe-peach.zip
		${MY_URI}/${MY_FRAPPE}-pink-standard+default.zip      -> ${P}-frappe-pink.zip
		${MY_URI}/${MY_FRAPPE}-red-standard+default.zip       -> ${P}-frappe-red.zip
		${MY_URI}/${MY_FRAPPE}-rosewater-standard+default.zip -> ${P}-frappe-rosewater.zip
		${MY_URI}/${MY_FRAPPE}-sapphire-standard+default.zip  -> ${P}-frappe-sapphire.zip
		${MY_URI}/${MY_FRAPPE}-sky-standard+default.zip       -> ${P}-frappe-sky.zip
		${MY_URI}/${MY_FRAPPE}-teal-standard+default.zip      -> ${P}-frappe-teal.zip
		${MY_URI}/${MY_FRAPPE}-yellow-standard+default.zip    -> ${P}-frappe-yellow.zip
	)
	latte? (
		${MY_URI}/${MY_LATTE}-blue-standard+default.zip      -> ${P}-latte-blue.zip
		${MY_URI}/${MY_LATTE}-flamingo-standard+default.zip  -> ${P}-latte-flamingo.zip
		${MY_URI}/${MY_LATTE}-green-standard+default.zip     -> ${P}-latte-green.zip
		${MY_URI}/${MY_LATTE}-lavender-standard+default.zip  -> ${P}-latte-lavender.zip
		${MY_URI}/${MY_LATTE}-maroon-standard+default.zip    -> ${P}-latte-maroon.zip
		${MY_URI}/${MY_LATTE}-mauve-standard+default.zip     -> ${P}-latte-mauve.zip
		${MY_URI}/${MY_LATTE}-peach-standard+default.zip     -> ${P}-latte-peach.zip
		${MY_URI}/${MY_LATTE}-pink-standard+default.zip      -> ${P}-latte-pink.zip
		${MY_URI}/${MY_LATTE}-red-standard+default.zip       -> ${P}-latte-red.zip
		${MY_URI}/${MY_LATTE}-rosewater-standard+default.zip -> ${P}-latte-rosewater.zip
		${MY_URI}/${MY_LATTE}-sapphire-standard+default.zip  -> ${P}-latte-sapphire.zip
		${MY_URI}/${MY_LATTE}-sky-standard+default.zip       -> ${P}-latte-sky.zip
		${MY_URI}/${MY_LATTE}-teal-standard+default.zip      -> ${P}-latte-teal.zip
		${MY_URI}/${MY_LATTE}-yellow-standard+default.zip    -> ${P}-latte-yellow.zip
	)
	macchiato? (
		${MY_URI}/${MY_MACCHIATO}-blue-standard+default.zip      -> ${P}-macchiato-blue.zip
		${MY_URI}/${MY_MACCHIATO}-flamingo-standard+default.zip  -> ${P}-macchiato-flamingo.zip
		${MY_URI}/${MY_MACCHIATO}-green-standard+default.zip     -> ${P}-macchiato-green.zip
		${MY_URI}/${MY_MACCHIATO}-lavender-standard+default.zip  -> ${P}-macchiato-lavender.zip
		${MY_URI}/${MY_MACCHIATO}-maroon-standard+default.zip    -> ${P}-macchiato-maroon.zip
		${MY_URI}/${MY_MACCHIATO}-mauve-standard+default.zip     -> ${P}-macchiato-mauve.zip
		${MY_URI}/${MY_MACCHIATO}-peach-standard+default.zip     -> ${P}-macchiato-peach.zip
		${MY_URI}/${MY_MACCHIATO}-pink-standard+default.zip      -> ${P}-macchiato-pink.zip
		${MY_URI}/${MY_MACCHIATO}-red-standard+default.zip       -> ${P}-macchiato-red.zip
		${MY_URI}/${MY_MACCHIATO}-rosewater-standard+default.zip -> ${P}-macchiato-rosewater.zip
		${MY_URI}/${MY_MACCHIATO}-sapphire-standard+default.zip  -> ${P}-macchiato-sapphire.zip
		${MY_URI}/${MY_MACCHIATO}-sky-standard+default.zip       -> ${P}-macchiato-sky.zip
		${MY_URI}/${MY_MACCHIATO}-teal-standard+default.zip      -> ${P}-macchiato-teal.zip
		${MY_URI}/${MY_MACCHIATO}-yellow-standard+default.zip    -> ${P}-macchiato-yellow.zip
	)
	mocha? (
		${MY_URI}/${MY_MOCHA}-blue-standard+default.zip      -> ${P}-mocha-blue.zip
		${MY_URI}/${MY_MOCHA}-flamingo-standard+default.zip  -> ${P}-mocha-flamingo.zip
		${MY_URI}/${MY_MOCHA}-green-standard+default.zip     -> ${P}-mocha-green.zip
		${MY_URI}/${MY_MOCHA}-lavender-standard+default.zip  -> ${P}-mocha-lavender.zip
		${MY_URI}/${MY_MOCHA}-maroon-standard+default.zip    -> ${P}-mocha-maroon.zip
		${MY_URI}/${MY_MOCHA}-mauve-standard+default.zip     -> ${P}-mocha-mauve.zip
		${MY_URI}/${MY_MOCHA}-peach-standard+default.zip     -> ${P}-mocha-peach.zip
		${MY_URI}/${MY_MOCHA}-pink-standard+default.zip      -> ${P}-mocha-pink.zip
		${MY_URI}/${MY_MOCHA}-red-standard+default.zip       -> ${P}-mocha-red.zip
		${MY_URI}/${MY_MOCHA}-rosewater-standard+default.zip -> ${P}-mocha-rosewater.zip
		${MY_URI}/${MY_MOCHA}-sapphire-standard+default.zip  -> ${P}-mocha-sapphire.zip
		${MY_URI}/${MY_MOCHA}-sky-standard+default.zip       -> ${P}-mocha-sky.zip
		${MY_URI}/${MY_MOCHA}-teal-standard+default.zip      -> ${P}-mocha-teal.zip
		${MY_URI}/${MY_MOCHA}-yellow-standard+default.zip    -> ${P}-mocha-yellow.zip
	)
"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+frappe latte macchiato mocha"
REQUIRED_USE="|| ( frappe latte macchiato mocha )"

BDEPEND="
	app-arch/unzip
"

src_install() {
	insinto "/usr/share/themes"
	for folder in * ; do
		if [ -d "${folder}" ]; then
			doins -r "${folder}"
		fi
	done
}
