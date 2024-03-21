# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
COMMIT="7e415b8ab843a64313708273cf659efbf471ad39"

DESCRIPTION="Plugin that modifies built-in up-or-search command to merge the command history"
HOMEPAGE="https://github.com/2m/fish-history-merge"
SRC_URI="https://github.com/2m/fish-history-merge/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="app-shells/fish"

S="${WORKDIR}/${PN}-${COMMIT}"
DOCS=( README.md )

src_install() {
	insinto "/usr/share/fish/vendor_functions.d"
	doins "functions/up-or-search.fish"
	einstalldocs
}
