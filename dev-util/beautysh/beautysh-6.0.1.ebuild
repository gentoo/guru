# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="This program takes upon itself the hard task of beautifying Bash scripts"
HOMEPAGE="http://uncrustify.sourceforge.net/"
SRC_URI="https://github.com/lovesegfault/beautysh/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86 ~amd64-linux ~ppc-macos ~x64-macos ~x64-solaris ~x86-solaris"

LICENSE="GPL-2"
SLOT="0"
