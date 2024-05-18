# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="dotenv implementation for Nim"
HOMEPAGE="
	https://github.com/euantorano/dotenv.nim
	https://nimble.directory/pkg/dotenv
"
SRC_URI="https://github.com/euantorano/${PN}.nim/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}.nim-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

set_package_url "https://github.com/euantorano/dotenv.nim"
