# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An fzf terminal UI for systemctl"
HOMEPAGE="https://github.com/joehillen/sysz"
SRC_URI="https://github.com/joehillen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Unlicense"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=app-shells/bash-4.3
	>=app-shells/fzf-0.27.1
	sys-apps/systemd
	virtual/awk
"

DOCS=( README.md CHANGELOG.md )

src_compile() {
	:
}

src_install() {
	dobin "${PN}"
	einstalldocs
}
