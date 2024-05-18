# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit nimble

COMMIT="8b7c1db069797300425037c98b825c5d3316f752"
DESCRIPTION="Simple Redis connection pool"
HOMEPAGE="
	https://github.com/zedeus/redpool
	https://nimble.directory/pkg/redpool
"
SRC_URI="https://github.com/zedeus/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="$(ver_cut 1-3)"
KEYWORDS="~amd64"

RDEPEND="dev-nim/zedeus_redis"

set_package_url "https://github.com/zedeus/redpool"
