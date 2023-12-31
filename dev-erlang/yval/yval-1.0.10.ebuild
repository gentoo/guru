# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit rebar3

DESCRIPTION="YAML validator"
HOMEPAGE="https://github.com/processone/yval"
SRC_URI="https://github.com/processone/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# Broken tests
RESTRICT="test"

DEPEND=">=dev-lang/erlang-21"
RDEPEND="${DEPEND}"
