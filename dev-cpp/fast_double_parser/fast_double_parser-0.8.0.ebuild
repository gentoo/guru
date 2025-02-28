# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Parse strings into double floating-point values"

HOMEPAGE="https://github.com/lemire/fast_double_parser"

SRC_URI="https://github.com/lemire/fast_double_parser/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="|| ( Apache-2.0 Boost-1.0 )"

SLOT="0"

KEYWORDS="~amd64"
