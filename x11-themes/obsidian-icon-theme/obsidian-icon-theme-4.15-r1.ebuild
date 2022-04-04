# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

GIT_PN="iconpack-obsidian"

inherit xdg

DESCRIPTION="Obsidian Icon Theme is intuitive Faenza-like icon theme"

HOMEPAGE="https://github.com/madmaxms/iconpack-obsidian"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/madmaxms/${GIT_PN}.git"
else
	SRC_URI="https://github.com/madmaxms/${GIT_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~riscv ~x86"
	S="${WORKDIR}/${GIT_PN}-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	x11-themes/adwaita-icon-theme
"

DEPEND="${RDEPEND}"

DOCS=( README.md )

src_install() {
	# Remove dead links to fix symbolic link does not exist QA.
	find . -xtype l -exec rm {} + || die
	# Install the icons
	insinto /usr/share/icons
	doins -r Obsidian*
}
