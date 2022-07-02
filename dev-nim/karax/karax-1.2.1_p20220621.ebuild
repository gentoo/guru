# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

COMMIT="11e56317633f3e9dc03b3b61250c587e2775c9fd"
DESCRIPTION="a framework for developing single page applications in Nim"
HOMEPAGE="
	https://github.com/karaxnim/karax
	https://nimble.directory/pkg/karax
"
SRC_URI="https://github.com/${PN}nim/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# no meaningful tests
RESTRICT="test"

RDEPEND="
	dev-nim/dotenv
	dev-nim/ws
"

set_package_url "https://github.com/karaxnim/karax"
