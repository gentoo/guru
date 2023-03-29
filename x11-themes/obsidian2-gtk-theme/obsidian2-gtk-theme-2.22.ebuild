# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

GIT_PN="theme-obsidian-2"

DESCRIPTION="Obsidian Gnome Theme, based upon Adwaita-Maia dark skin"

HOMEPAGE="https://github.com/madmaxms/theme-obsidian-2"

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

RDEPEND=""
DEPEND="${RDEPEND}"

DOCS=( README.md )

src_install() {
	insinto /usr/share/themes
	doins -r Obsidian*
}
