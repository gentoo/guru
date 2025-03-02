# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Soothing pastel mouse cursors"
HOMEPAGE="https://github.com/catppuccin"

MY_URI="https://github.com/catppuccin/cursors/releases/download/v${PV}"
MY_TYPES=("latte" "frappe" "mocha" "macchiato")
MY_COLORS=(
	"blue" "dark" "flamingo" "green" "lavender" "light" "maroon"
	"mauve" "peach" "pink" "red" "rosewater" "sapphire" "sky" "teal" "yellow"
)

SRC_URI=""
for type in "${MY_TYPES[@]}"; do
	for color in "${MY_COLORS[@]}"; do
		SRC_URI+=" ${MY_URI}/catppuccin-${type}-${color}-cursors.zip -> ${P}-${type}-${color}.zip"
	done
done

S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-arch/unzip"

src_install() {
	insinto "/usr/share/icons"
	for folder in * ; do
		if [ -d "${folder}" ]; then
			doins -r "${folder}"
		fi
	done
}
