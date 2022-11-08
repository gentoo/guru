# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs shards

DESCRIPTION="Feature-rich testing framework for Crystal inspired by RSpec"
HOMEPAGE="https://github.com/icy-arctic-fox/spectator"
SRC_URI="https://github.com/icy-arctic-fox/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {ARCHITECTURE,CHANGELOG,CONTRIBUTING,README}.md )

CHECKREQS_MEMORY="3G"

pkg_pretend() {
	has test "${FEATURES}" && check-reqs_pkg_pretend
}

pkg_setup() {
	has test "${FEATURES}" && check-reqs_pkg_setup
}
