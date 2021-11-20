# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit wrapper

DESCRIPTION="New dialect of Lisp, works well for basic web apps"
HOMEPAGE="http://www.arclanguage.org/"
SRC_URI="http://www.arclanguage.org/${PN}${PV}.tar -> ${P}.tar"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-scheme/racket"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}${PV}"

src_compile() {
	local mod
	for mod in ac brackets ; do
		raco make --vv ./${mod}.scm
	done
}

src_install() {
	dodoc "copyright" "how-to-run-news"
	rm "copyright" "how-to-run-news" || die

	insinto "/usr/share/arc"
	doins -r *

	make_wrapper ${PN} "racket --load ./as.scm" /usr/share/arc
}
