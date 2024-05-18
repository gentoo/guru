# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-/}"
FONT_PN="${MY_PN}"
FONT_SUFFIX="otf ttf"
inherit font

COMMIT="52737d952f91eb046ecfef27d4245fa81d7c141f"
DESCRIPTION="Font for sitelen pona, a script for toki pona"
HOMEPAGE="https://github.com/janMelon/linjawawa"
SRC_URI="https://github.com/janMelon/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${COMMIT}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( README.md misc )

src_unpack() {
	default

	# make fonts discoverable for font_src_install
	cd "${S}"
	for suffix in ${FONT_SUFFIX}; do
		cp "font-files/${MY_PN}${PV}.${suffix}" . || die
	done
}
