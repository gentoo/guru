# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Nim implementation of Google's Snappy compression"
HOMEPAGE="
	https://github.com/guzba/supersnappy
	https://nimble.directory/pkg/supersnappy
"
SRC_URI="https://github.com/guzba/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

set_package_url "https://github.com/guzba/supersnappy"
