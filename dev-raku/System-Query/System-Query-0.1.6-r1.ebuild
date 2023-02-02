# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

DESCRIPTION="It collapses JSON dependent upon certain environmental information"
HOMEPAGE="https://raku.land/zef:tony-o/System::Query"
SRC_URI="mirror://zef/S/YS/SYSTEM_QUERY/d254fdd0efd10a06bde98ee99b6ab1349532760a.tar.gz -> ${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="primaryuri"
DOCS="README.md"
BDEPEND="test? ( dev-raku/JSON-Fast )"
S="${WORKDIR}"
