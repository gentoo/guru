# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

DESCRIPTION="Serialize native Nim types to strings, streams, sockets, or anything else"
HOMEPAGE="https://github.com/disruptek/frosty"
SRC_URI="https://github.com/disruptek/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? (
	>dev-nim/balls-2.0.0
	<dev-nim/balls-4.0.0
)"

set_package_url "https://github.com/disruptek/frosty"
