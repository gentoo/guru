
EAPI=8

DESCRIPTION="Catppuccin is a community-driven pastel theme."
HOMEPAGE="https://github.com/catppuccin"

MY_URI="https://github.com/catppuccin/gtk/releases/download/v${PV}/"
MY_FRAPPE="Catppuccin-Frappe-Standard"
MY_LATTE="Catppuccin-Latte-Standard"

SRC_URI="
	frappe? ( ${MY_URI}/${MY_FRAPPE}-Blue-Dark.zip      -> ${P}-frappe-blue-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Flamingo-Dark.zip  -> ${P}-frappe-flamingo-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Green-Dark.zip     -> ${P}-frappe-green-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Lavender-Dark.zip  -> ${P}-frappe-lavender-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Maroon-Dark.zip    -> ${P}-frappe-maroon-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Mauve-Dark.zip     -> ${P}-frappe-mauve-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Peach-Dark.zip     -> ${P}-frappe-peach-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Pink-Dark.zip      -> ${P}-frappe-pink-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Red-Dark.zip       -> ${P}-frappe-red-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Rosewater-Dark.zip -> ${P}-frappe-rosewater-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Sapphire-Dark.zip  -> ${P}-frappe-sapphire-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Sky-Dark.zip       -> ${P}-frappe-sky-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Teal-Dark.zip      -> ${P}-frappe-teal-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Yellow-Dark.zip    -> ${P}-frappe-yellow-dark.zip
	)
	latte? ( ${MY_URI}/${MY_LATTE}-Blue-Light.zip      -> ${P}-latte-blue-light.zip
			 ${MY_URI}/${MY_LATTE}-Flamingo-Light.zip  -> ${P}-latte-flamingo-light.zip
			 ${MY_URI}/${MY_LATTE}-Green-Light.zip     -> ${P}-latte-green-light.zip
			 ${MY_URI}/${MY_LATTE}-Lavender-Light.zip  -> ${P}-latte-lavender-light.zip
			 ${MY_URI}/${MY_LATTE}-Maroon-Light.zip    -> ${P}-latte-maroon-light.zip
			 ${MY_URI}/${MY_LATTE}-Mauve-Light.zip     -> ${P}-latte-mauve-light.zip
			 ${MY_URI}/${MY_LATTE}-Peach-Light.zip     -> ${P}-latte-peach-light.zip
			 ${MY_URI}/${MY_LATTE}-Pink-Light.zip      -> ${P}-latte-pink-light.zip
			 ${MY_URI}/${MY_LATTE}-Red-Light.zip       -> ${P}-latte-red-light.zip
			 ${MY_URI}/${MY_LATTE}-Rosewater-Light.zip -> ${P}-latte-rosewater-light.zip
			 ${MY_URI}/${MY_LATTE}-Sapphire-Light.zip  -> ${P}-latte-sapphire-light.zip
			 ${MY_URI}/${MY_LATTE}-Sky-Light.zip       -> ${P}-latte-sky-light.zip
			 ${MY_URI}/${MY_LATTE}-Teal-Light.zip      -> ${P}-latte-teal-light.zip
			 ${MY_URI}/${MY_LATTE}-Yellow-Light.zip    -> ${P}-latte-yellow-light.zip
	)
"
S="${WORKDIR}"

IUSE="+frappe latte"
REQUIRED_USE="|| ( frappe latte )"

BDEPEND="
	app-arch/unzip
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	insinto "/usr/share/themes"
	for folder in * ; do
		if [ -d "${folder}" ]; then
			doins -r "${folder}"
		fi
	done
}
