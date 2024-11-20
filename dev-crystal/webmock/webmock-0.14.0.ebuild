# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

MY_PN="${PN}.cr"
DESCRIPTION="Mock HTTP client"
HOMEPAGE="https://github.com/manastech/webmock.cr"
SRC_URI="https://github.com/manastech/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.md )
