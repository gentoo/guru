# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="A compile-time, compact, fast, without allocation, state-machine generator"
HOMEPAGE="
	https://github.com/mratsim/Synthesis
	https://nimble.directory/pkg/synthesis
"
SRC_URI="https://github.com/mratsim/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P^}"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="~amd64"

set_package_url "https://github.com/mratsim/Synthesis"
