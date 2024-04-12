EAPI=8

DESCRIPTION="Soothing pastel theme for btop"
HOMEPAGE="https://github.com/catppuccin"

SRC_URI="
	https://github.com/catppuccin/btop/releases/download/${PV}/themes.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/themes"

RDEPEND="
	sys-process/btop
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	insinto "/usr/share/btop/themes"
	doins *.theme
}
