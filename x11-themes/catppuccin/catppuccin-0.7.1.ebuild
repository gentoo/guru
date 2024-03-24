
EAPI=8

DESCRIPTION="Catppuccin is a community-driven pastel theme."
HOMEPAGE="https://github.com/catppuccin"
MY_URI="https://github.com/${PN}/gtk/releases/download/v${PV}/"
MY_FRAPPE="Catppuccin-Frappe-Standard"
SRC_URI="
	frappe? ( ${MY_URI}/${MY_FRAPPE}-Blue-Dark.zip      -> ${P}-blue-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Flamingo-Dark.zip  -> ${P}-flamingo-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Green-Dark.zip     -> ${P}-green-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Lavender-Dark.zip  -> ${P}-lavender-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Maroon-Dark.zip    -> ${P}-maroon-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Mauve-Dark.zip     -> ${P}-mauve-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Peach-Dark.zip     -> ${P}-peach-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Pink-Dark.zip      -> ${P}-pink-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Red-Dark.zip       -> ${P}-red-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Rosewater-Dark.zip -> ${P}-rosewater-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Sapphire-Dark.zip  -> ${P}-sapphire-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Sky-Dark.zip       -> ${P}-sky-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Teal-Dark.zip      -> ${P}-teal-dark.zip
			  ${MY_URI}/${MY_FRAPPE}-Yellow-Dark.zip    -> ${P}-yellow-dark.zip
	)
"
S="${WORKDIR}"

IUSE="+frappe"
REQUIRED_USE="|| ( frappe )"

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
