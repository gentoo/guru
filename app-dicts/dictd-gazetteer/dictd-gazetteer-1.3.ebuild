# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="The original U.S. Gazetteer Place and Zipcode Files for dict"
HOMEPAGE="https://sourceforge.net/projects/dict-gazetteer"
SRC_URI="mirror://sourceforge/project/dict-gazetteer/dict-gazetteer_${PV}.orig.tar.gz"
S="${WORKDIR}/dict-gazetteer-${PV}"
LICENSE="GPL-2 public-domain"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=app-text/dictd-1.5.5"

PATCHES=(
	"${FILESDIR}/${PN}-fix-makefile.patch"
	"${FILESDIR}/${PN}-fix-paths.patch"
)

src_prepare() {
	default
	eautoreconf
	mkdir -p "${T}/dict" || die
}

src_configure() {
	econf --datadir="${T}"
}

src_compile() {
	emake
	emake db
}

src_install() {
	emake install
	insinto "/usr/share"
	doins -r "${T}/dict"
}
