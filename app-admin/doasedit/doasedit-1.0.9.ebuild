# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} != "9999" ]]; then
	SRC_URI="https://codeberg.org/TotallyLeGIT/doasedit/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}"
else
	inherit git-r3
	EGIT_REPO_URI="https://codeberg.org/TotallyLeGIT/doasedit.git"
	S="${WORKDIR}/${P}"
fi

DESCRIPTION="Edit files as root using an unprivileged editor"
HOMEPAGE="https://codeberg.org/TotallyLeGIT/doasedit"

LICENSE="MIT"
SLOT="0"
RESTRICT="strip test"

RDEPEND="
	app-admin/doas
"

src_compile() {
	:
}

src_install() {
	emake prefix="${D}"/usr install
	einstalldocs
}
