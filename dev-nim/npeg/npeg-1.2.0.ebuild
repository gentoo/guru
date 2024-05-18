# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="a PEG library for Nim"
HOMEPAGE="https://github.com/zevv/npeg https://nimble.directory/pkg/npeg"
SRC_URI="https://github.com/zevv/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

DOCS=( {Changelog,INTERNALS,README}.md )

set_package_url "https://github.com/zevv/npeg"

src_test() {
	nimble_build testc
}
