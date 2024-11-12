# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="HTTP Proxy server and client written in Crystal"
HOMEPAGE="https://github.com/mamantoha/http_proxy"
SRC_URI="https://github.com/mamantoha/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {CHANGELOG,README}.md )
