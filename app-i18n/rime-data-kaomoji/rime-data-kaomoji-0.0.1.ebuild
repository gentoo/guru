# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

MY_PN="rime-kaomoji"

DESCRIPTION="kaomoji input schema for RIME"
HOMEPAGE="https://rime.im/ https://github.com/Freed-Wu/rime-kaomoji"
SRC_URI="https://github.com/Freed-Wu/rime-kaomoji/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS=(
	LICENSE
	README.md
)

src_install() {
	insinto /usr/share/rime-data
	doins kaomoji_suggestion.yaml
	doins -r opencc

	einstalldocs
}
