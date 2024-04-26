# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fast CLI search tool, faster than grep, ack, silver_searcher (ag)"
HOMEPAGE="https://github.com/monochromegane/the_platinum_searcher"
SRC_URI="https://github.com/monochromegane/the_platinum_searcher/releases/download/v${PV}/pt_linux_amd64.tar.gz"

S="${WORKDIR}/pt_linux_amd64"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	dobin pt
}
