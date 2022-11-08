# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit shards

DESCRIPTION="Framework agnostic content negotiation library"
HOMEPAGE="https://github.com/athena-framework/negotiation"
SRC_URI="https://github.com/athena-framework/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? (
	dev-crystal/athena-spec
)"

DOCS=( {CHANGELOG,README}.md )
