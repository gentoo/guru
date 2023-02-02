# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit rakudo

DESCRIPTION="A Raku module for encoding / decoding URIs"
HOMEPAGE="https://github.com/raku-community-modules/URI-Encode"
SRC_URI="mirror://zef/U/RI/URI_ENCODE/44046038356c5e83ec603dff2486d91870355c28.tar.gz -> ${P}.tar.gz"
LICENSE="FreeBSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="primaryuri"
DOCS="README.md"
S="${WORKDIR}/dist"
