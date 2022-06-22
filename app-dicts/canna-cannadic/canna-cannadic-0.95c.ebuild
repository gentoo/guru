# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CANNADICS=( gcanna gcannaf )
DICSDIRFILE="${FILESDIR}/05cannadic.dics.dir"
MY_P="${P/canna-/}"

inherit cannadic

DESCRIPTION="Japanese dictionary as a supplement/replacement to Canna3.5b2"
HOMEPAGE="https://web.archive.org/web/20150905224451/http://cannadic.oucrc.org/"
SRC_URI="https://web.archive.org/web/20150919101016if_/http://cannadic.oucrc.org/${MY_P}.tar.gz -> ${MY_P}.tar"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="app-i18n/canna"

src_compile() {
	emake maindic
}
