# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

FONT_SUFFIX="pcf.gz"
FONT_S=( . hidpi )
inherit font-ebdftopcf font

COMMIT="cc36b8c9fed7141763e55dcee0a97abffcf08224"
DESCRIPTION="A monospace bitmap font"
HOMEPAGE="
	https://font.gohu.org
	https://github.com/hchargois/gohufont
"
SRC_URI="
	https://github.com/hchargois/gohufont/archive/${COMMIT}.tar.gz -> ${P}.tar.gz
"
S="${WORKDIR}/${PN}-${COMMIT}"
LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	font-ebdftopcf_src_compile
}
