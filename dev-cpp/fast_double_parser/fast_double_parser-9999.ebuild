# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Parse strings into double floating-point values"
HOMEPAGE="https://github.com/lemire/fast_double_parser"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	# the library depends (and fetches) on dev-cpp/abseil-cpp and
	# dev-libs/double-conversion but just for its benchmarking code
	EGIT_SUBMODULES=()
	EGIT_REPO_URI="https://github.com/lemire/fast_double_parser"
else
	SRC_URI="https://github.com/lemire/fast_double_parser/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
