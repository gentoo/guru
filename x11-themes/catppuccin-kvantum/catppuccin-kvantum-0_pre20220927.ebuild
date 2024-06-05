# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Soothing pastel theme for Kvantum"
HOMEPAGE="https://github.com/catppuccin"

S="${WORKDIR}/Kvantum-${MY_COMMIT}/src"
if [[ "${PV}" == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/catppuccin/Kvantum.git"
	inherit git-r3
	S="${WORKDIR}/${P}/src"
else
	MY_COMMIT="04be2ad3d28156cfb62478256f33b58ee27884e9"
	SRC_URI="https://github.com/catppuccin/Kvantum/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/Kvantum-${MY_COMMIT}/src"
	KEYWORDS="~amd64"
fi

RDEPEND="
	x11-themes/kvantum
"

LICENSE="MIT"
SLOT="0"

src_install() {
	insinto "/usr/share/Kvantum"
	doins -r Catppuccin-*
}
