# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

COMMIT="56db8bb9dfbd5ed6d7908353405a5fae632a6561"
DESCRIPTION="Crystal language Tar Module implements access to tar archives"
HOMEPAGE="https://github.com/naqvis/crystar"
SRC_URI="https://github.com/naqvis/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
