# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

MY_PN="${PN#athena-}"
DESCRIPTION="Framework agnostic content negotiation library"
HOMEPAGE="https://github.com/athena-framework/negotiation"
SRC_URI="https://github.com/athena-framework/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-crystal/athena-spec )"

DOCS=( {CHANGELOG,CONTRIBUTING,README}.md )
