# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

MY_PN="${PN}.cr"
DESCRIPTION="Liquid template engine for Crystal"
HOMEPAGE="https://github.com/TechMagister/liquid.cr"
SRC_URI="https://github.com/TechMagister/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-crystal/inflector
	dev-crystal/json_mapping
"
