# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Monitor a tree for files with spaces in name - and replace to underscores"
HOMEPAGE=""https://gitlab.com/vitaly-zdanevich/watch-tree-and-replace-spaces-with-a-few-other-chars
SRC_URI="https://gitlab.com/vitaly-zdanevich/$PN/-/archive/$PV/$P.tar.bz2"

LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="~amd64 ~x86"

src_install() {
	dobin "${PN}".sh
}

pkg_postinst() {
	elog: "How to use: run in terminal in a folder - and in another software create a file with space in name, in that folder"
}
