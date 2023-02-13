# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="766d34590e1fc0edddb381ad16fab57f5d20d299"

DESCRIPTION="Generates random text from datafiles and templates"
HOMEPAGE="
	https://github.com/aduial/nonsense
	https://sourceforge.net/projects/nonsense/
	https://nonsense.sourceforge.net
"
SRC_URI="https://github.com/aduial/nonsense/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	newbin "${FILESDIR}/nonsense.sh" nonsense
	dodoc README.md CHANGELOG.md HOWTO.md
	insinto /usr/share/nonsense
	doins *.data *.html *.template nonsense.pl
}
