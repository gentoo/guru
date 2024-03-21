# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="sparklines for your shell"
HOMEPAGE="
	https://zachholman.com/spark/
	https://github.com/holman/spark
"
SRC_URI="https://github.com/holman/spark/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
#IUSE="test" #require roundup

RDEPEND="${DEPEND}"

src_install() {
	dobin spark
	dodoc {CHANGELOG,README}.md
}

#src_test() {
#}
