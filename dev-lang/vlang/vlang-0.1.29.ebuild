# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Simple, fast, safe compiled language for developing maintainable software."
HOMEPAGE="https://vlang.io"
SRC_URI="https://github.com/vlang/v"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile(){
	cd v && emake || die "Emake failed, contact the maintainers ;("
	# Adds to PATH via symlink
	./v symlink
}
