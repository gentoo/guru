# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="a framework for developing single page applications in Nim"
HOMEPAGE="
	https://github.com/karaxnim/karax
	https://nimble.directory/pkg/karax
"
SRC_URI="https://github.com/${PN}nim/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-nim/dotenv
	dev-nim/ws
"
BDEPEND="
	test? (
		${RDEPEND}
		net-libs/nodejs
	)
"

set_package_url "https://github.com/karaxnim/karax"
